resource "cloudflare_record" "default" {
  zone_id = var.cloudflare_zone_id
  name    = local.hostname
  value   = azurerm_cdn_endpoint.default.fqdn
  type    = "CNAME"
  ttl     = 3600
  proxied = true
}