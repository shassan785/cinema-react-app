resource "aws_s3_bucket" "cinema_app_s3_bucket" {
  bucket = "${var.prefix}-app"
  force_destroy = true

  tags = local.commom_tags
}
resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.cinema_app_s3_bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.cinema_app_s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.cinema_app_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_policy" "cinema_app_bucket_policy" {
  bucket = aws_s3_bucket.cinema_app_s3_bucket.id
  policy = data.aws_iam_policy_document.policy_doc.json
}
data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [
      aws_s3_bucket.cinema_app_s3_bucket.arn,
      "${aws_s3_bucket.cinema_app_s3_bucket.arn}/*"
    ]

    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cinema.app_origin_access.iam_arn]
    }
  }
}