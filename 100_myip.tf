data "http" "ip" {
  url = "https://ifconfig.me"
}

output "my_public_ip" {
  value = data.http.ip.body
}