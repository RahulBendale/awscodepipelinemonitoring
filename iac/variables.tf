variable "global_tags" {
    description = "All Cloud network global tags for my-company"
    type = map(string)
    default = {
      "Author" = "my company devops",
      "Environment" = "dev",
      "Region" = "{{AWS_REGION}}",
      "Provisioner" = "Terraform",
      "Project" = "my-company",
      "SsecurityZone" = "D1",
      "TaggingVersion" = "v2.0"
      "BusinessServie" = "mycompany:APPL:za:DEV"
      "Confidentiality" = "C3"
    }
}