resource "aws_key_pair" "tf_dev_key" {
    key_name = "jvelez_tf_key"
    public_key = file("~/.ssh/tfdev.pub")
}