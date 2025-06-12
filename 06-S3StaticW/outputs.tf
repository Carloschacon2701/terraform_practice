output "s3_output" {
  value       = aws_s3_bucket_website_configuration.webPage.website_endpoint
  description = "S3 endpoint of the web server"
}
