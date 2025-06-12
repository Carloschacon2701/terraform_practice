resource "random_id" "bucket_name" {
  byte_length = 8
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "example-bucket-${random_id.bucket_name.hex}"

}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.bucket

}
