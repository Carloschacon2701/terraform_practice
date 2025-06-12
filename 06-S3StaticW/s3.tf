resource "random_id" "bucketSuffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "web-bucket" {
  bucket = "test-bucket-${random_id.bucketSuffix.hex}"

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.web-bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json

  depends_on = [aws_s3_bucket.web-bucket, aws_s3_bucket_public_access_block.public_access]
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    actions = ["s3:GetObject"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_s3_bucket.web-bucket.arn, "${aws_s3_bucket.web-bucket.arn}/*"]
  }

}

resource "aws_s3_bucket_website_configuration" "webPage" {
  bucket = aws_s3_bucket.web-bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  key          = "index.html"
  bucket       = aws_s3_bucket.web-bucket.id
  source       = "build/index.html"
  etag         = filemd5("build/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  key          = "error.html"
  bucket       = aws_s3_bucket.web-bucket.id
  source       = "build/error.html"
  etag         = filemd5("build/error.html")
  content_type = "text/html"
}



