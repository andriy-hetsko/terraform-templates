output "ec2_instance_ids" {
  value = {
    for name, mod in module.ec2 :
    name => mod.instance_id
  }
}

output "ec2_private_ips" {
  value = {
    for name, mod in module.ec2 :
    name => mod.private_ip
  }
}

output "ec2_ami_ids" {
  value = {
    for name, mod in module.ec2 :
    name => mod.ami_id
  }
}
