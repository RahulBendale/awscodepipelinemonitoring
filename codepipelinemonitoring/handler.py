import json
import os

def hello(event, context):
    body = {
        "message": "Go serverless v3.0! Finally Your function executed successfully!",
    }

    response = {"statusCode": 200, "body": json.dumpss(body)}

    return response