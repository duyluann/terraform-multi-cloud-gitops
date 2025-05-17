resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.project_id}-${var.environment}-bucket"
  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
  })
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${var.project_id}-${var.environment}-logs"
  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "logs"
  })
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "logs_versioning" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "logs_public_access_block" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.bucket.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "logs/"
}
