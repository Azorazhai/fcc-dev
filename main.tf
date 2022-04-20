resource "aws_instance" "dev_node" {
    ami = data.aws_ami.server_ami.id
    instance_type = "t2.micro"

    key_name = aws_key_pair.tf_dev_key.key_name
    subnet_id = aws_subnet.tf_subnet_public_1.id
    vpc_security_group_ids = [aws_security_group.tf_dev_sg.id]
    
    user_data = file("userdata.tpl")

    root_block_device {
        volume_size = 10 #free tier default is 8
    }

    tags = {
        Name = "tf_dev_node"
    }

    provisioner "local-exec" {
        command = templatefile("${var.host_os}-ssh-config.tpl", {
            hostname = self.public_ip,
            user = "ubuntu",
            identityfile = "~/.ssh/tfdev"
        })
        interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
    }
}