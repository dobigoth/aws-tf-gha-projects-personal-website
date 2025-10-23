resource "aws_s3_bucket" "static_sites_dobigoth" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_sites_dobigoth.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "access_dobigoth" {
  bucket = aws_s3_bucket.static_sites_dobigoth.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_sites_dobigoth.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
depends_on = [ aws_s3_bucket_public_access_block.access_dobigoth ]
}

# #tfsec:ignore:aws-s3-enable-bucket-logging
# resource "aws_s3_bucket" "static_sites_dobigoth" {
#   bucket = var.bucket_name
#   force_destroy = true
# }

# resource "aws_s3_bucket_website_configuration" "static_website_config" {
#   bucket = aws_s3_bucket.static_sites_dobigoth

#   index_document {
#     suffix = "index.html"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "access_dobigoth" {
#   bucket = aws_s3_bucket.static_sites_dobigoth.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "static_site_policy" {
#   bucket = aws_s3_bucket.static_sites_dobigoth.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.static_site.arn}/*"
#       }
#     ]
#   })

#   depends_on = [ aws_s3_bucket_public_access_block.static_site_access ]
# }

# # resource "aws_s3_bucket_ownership_controls" "ownership_dobigoth" {
# #   bucket = aws_s3_bucket.static_sites_dobigoth.id
# #   rule {
# #     object_ownership = "BucketOwnerPreferred"
# #   }
# # }

# # resource "aws_s3_bucket_acl" "acl_dobigoth" {
# #   #depends_on = [aws_s3_bucket_ownership_controls.example]
# #   bucket = aws_s3_bucket.static_sites_dobigoth.id
# #   acl    = "private"

# # }



# # }

# # resource "aws_s3_bucket_versioning" "versioning_example" {
# #   bucket = aws_s3_bucket.static_sites_dobigoth.id
# #   versioning_configuration {
# #     status = "Enabled"
# #   }
# # }

# # resource "aws_kms_key" "mykey" {
# #   description             = "This key is used to encrypt bucket objects"
# #   enable_key_rotation     = true
# #   deletion_window_in_days = 7
# # }

# # resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
# #   bucket = aws_s3_bucket.static_sites_dobigoth.id

# #   rule {
# #     apply_server_side_encryption_by_default {
# #       kms_master_key_id = aws_kms_key.mykey.arn
# #       sse_algorithm     = "aws:kms"
# #     }
# #   }
# # }