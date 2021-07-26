resource "aws_sns_topic" "cicd_alerts" {
  count = var.enable_cicd_alert ? 1 : 0

  tags = var.tags
  name = "${var.project_prefix}-cicd-alerts"
}

data "aws_iam_policy_document" "sns_topic_policy_doc" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com", "cloudwatch.amazonaws.com"]
    }
    resources = [aws_sns_topic.cicd_alerts[0].arn]
  }
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  count = var.enable_cicd_alert ? 1 : 0

  arn    = aws_sns_topic.cicd_alerts[0].arn
  policy = data.aws_iam_policy_document.sns_topic_policy_doc.json
}