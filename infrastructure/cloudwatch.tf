resource "aws_cloudwatch_event_rule" "codebuild_status_change" {

  name = "${var.project_prefix}-codebuild-status-change"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codebuild"
  ],
  "detail-type": [
    "CodeBuild Build State Change"
  ],
  "detail": {
    "build-status": [
      "IN_PROGRESS",
      "SUCCEEDED",
      "FAILED",
      "STOPPED"
    ],
    "project-name": [
      "${aws_codebuild_project.codebuild.name}"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "target_sns" {

  rule      = aws_cloudwatch_event_rule.codebuild_status_change.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.cicd_alerts[0].arn
  input_transformer {
    input_paths    = { "build-status" : "$.detail.build-status", "project-name" : "$.detail.project-name", "build-id" : "$.detail.build-id" }
    input_template = <<INPUT
    {
      "Build ID"          : "<build-id>",
      "Build Project"     : "<project-name>",
      "Build Status"      : "<build-status>",
      "Description"       : "Build '<build-id>' for build project '<project-name>' has reached the build status of '<build-status>'."
    }
    INPUT
  }
}