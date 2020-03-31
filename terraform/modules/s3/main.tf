resource "random_id" "randomid" {

  byte_length = 2
}
/* s3 bucket creation */
resource "aws_s3_bucket" "s3" {
  bucket = "${var.mys3bucket_name}-${random_id.randomid.dec}"

}

