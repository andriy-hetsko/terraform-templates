output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "ami_id" {
  value = data.aws_ami.this.id
}
