# Specify the provider and AWS region
provider "aws" {
  region = "ap-south-1"
}

# 1. Create EventBridge Event Bus
resource "aws_cloudwatch_event_bus" "my_event_bus" {
  name = "my-event-bus"
}

# 2. Create EventBridge Rule to capture events
resource "aws_cloudwatch_event_rule" "my_event_rule" {
  name        = "my-event-rule"
  description = "Capture events from EventBridge"
  event_bus_name = aws_cloudwatch_event_bus.my_event_bus.name
  
  # Event pattern to match specific events (customize as per your use case)
  event_pattern = jsonencode({
    source = ["aws.codepipeline"],
    "detail-type" = ["CodePipeline Pipeline Execution State Change"],
  })
  tags = merge(
    var.global_tags,
    {
        "Name" = "codepiepline_eventbridge_monitoring"
    }
  )
}

# 3. Create a target for the EventBridge rule (e.g., Lambda function)
# Assume we have an AWS Lambda function already created (referenced here by ARN)

resource "aws_cloudwatch_event_target" "my_event_target" {
  rule      = aws_cloudwatch_event_rule.my_event_rule.name
  target_id = "my-lambda-target"
  arn       = "arn:aws:lambda:ap-south-1:248189941331:function:codepipelinemonitoring"

  # Optional: Pass specific input to the target (e.g., EventBridge event)
  input = jsonencode({
    message = "Event received!"
  })
}

# 4. Grant permissions to EventBridge to invoke Lambda (if using Lambda target)
resource "aws_lambda_permission" "allow_eventbridge_invocation" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = "codepipeline_monitoring"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.my_event_rule.arn
}