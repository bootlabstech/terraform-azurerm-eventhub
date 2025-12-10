# -------------------------
# Event Hub Namespace
# -------------------------

resource "azurerm_eventhub_namespace" "eh_namespace" {
  name                = "${var.name}-evnthbnamespace"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_network_access_enabled = var.public_network_access_enabled

  sku                 = var.namespace_sku
  capacity            = var.namespace_capacity
}

# -------------------------
# Event Hub
# -------------------------

resource "azurerm_eventhub" "eventhub" {
  name                = var.name
  namespace_id = azurerm_eventhub_namespace.eh_namespace.id
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}

# -------------------------
# Authorization Rule
# -------------------------

resource "azurerm_eventhub_authorization_rule" "auth_rule" {
  name                = var.auth_rule_name
  eventhub_name       = azurerm_eventhub.eventhub.name
  namespace_name      = azurerm_eventhub_namespace.eh_namespace.name
  resource_group_name = var.resource_group_name
  

  listen = var.listen
  send   = var.send
  manage = var.manage
}

# -------------------------
# PRIVATE ENDPOINT
# -------------------------
resource "azurerm_private_dns_zone" "eventhub_dns" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "pe_eventhub" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id   # Existing subnet

  private_service_connection {
    name                           = "${var.name}eh-psc"
    private_connection_resource_id = azurerm_eventhub_namespace.eh_namespace.id
    subresource_names              = ["namespace"]  # REQUIRED for Event Hub
    is_manual_connection           = false
  }
 private_dns_zone_group {
  name = "${var.name}-dnszone"
  private_dns_zone_ids = [
    azurerm_private_dns_zone.eventhub_dns.id
  ]
}
}

# resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
#   name                  = "${var.name}-dnslink"
#   resource_group_name   = var.resource_group_name
#   private_dns_zone_name = azurerm_private_dns_zone.eventhub_dns.name
#   virtual_network_id    = var.vnet_id
# }
