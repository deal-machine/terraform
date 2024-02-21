resource "aws_ssm_parameter" "bible_api" {
  name  = "${var.prefix}-bible-api"
  type  = "String"
  value = "https://labs.bible.org/api/?passage=random&type=json"
}