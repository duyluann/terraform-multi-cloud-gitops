resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project_id}-${var.environment}-bucket"
  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}

resource "aws_s3_bucket_region" "bucket_region" {
  bucket = aws_s3_bucket.bucket.id
  region = var.region
}