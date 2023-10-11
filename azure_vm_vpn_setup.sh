#!/bin/bash

# Exit on any command error
set -e

# Variables
resourceGroupName="MyResourceGroup"
location="eastus"
vnet1Name="VNet1"
vnet2Name="VNet2"
gatewaySubnetPrefixVNet1="10.1.255.0/27"
gatewaySubnetPrefixVNet2="10.2.255.0/27"
vpnGateway1Name="VpnGateway1"
vpnGateway2Name="VpnGateway2"
sharedKey="Abc123"
vm1Name="VM1"
vm2Name="VM2"
vmSubnet1Prefix="10.1.1.0/24"
vmSubnet2Prefix="10.2.1.0/24"
vmSubnetName="VmSubnet"

# Check if the resource group exists
EXISTING_RG=$(az group exists --name $resourceGroupName)

if [ "$EXISTING_RG" == "true" ]; then
    echo "Removing the resource group..."
    az group delete --name $resourceGroupName --yes
fi

echo "Creating resource group..."
az group create --name $resourceGroupName --location $location

echo "Creating VNet1 with GatewaySubnet..."
az network vnet create --resource-group $resourceGroupName --name $vnet1Name --address-prefix 10.1.0.0/16 --subnet-name GatewaySubnet --subnet-prefix $gatewaySubnetPrefixVNet1 --location $location

echo "Creating VNet2 with GatewaySubnet..."
az network vnet create --resource-group $resourceGroupName --name $vnet2Name --address-prefix 10.2.0.0/16 --subnet-name GatewaySubnet --subnet-prefix $gatewaySubnetPrefixVNet2 --location $location

echo "Creating Public IP for VPN Gateway 1..."
az network public-ip create --name MyGatewayIp1 --resource-group $resourceGroupName --location $location --allocation-method Dynamic

echo "Creating Public IP for VPN Gateway 2..."
az network public-ip create --name MyGatewayIp2 --resource-group $resourceGroupName --location $location --allocation-method Dynamic

echo "Creating VPN Gateway for VNet1..."
az network vnet-gateway create --name $vpnGateway1Name --resource-group $resourceGroupName --location $location --vnet $vnet1Name --public-ip-address MyGatewayIp1 --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased

echo "Creating VPN Gateway for VNet2..."
az network vnet-gateway create --name $vpnGateway2Name --resource-group $resourceGroupName --location $location --vnet $vnet2Name --public-ip-address MyGatewayIp2 --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased

echo "Creating VNet-to-VNet connections..."
az network vpn-connection create --name "VNet1toVNet2" --resource-group $resourceGroupName --vnet-gateway1 $vpnGateway1Name --vnet-gateway2 $vpnGateway2Name --shared-key $sharedKey

az network vpn-connection create --name "VNet2toVNet1" --resource-group $resourceGroupName --vnet-gateway1 $vpnGateway2Name --vnet-gateway2 $vpnGateway1Name --shared-key $sharedKey

echo "Creating VM subnet for VNet1..."
az network vnet subnet create --name $vmSubnetName --resource-group $resourceGroupName --vnet-name $vnet1Name --address-prefix $vmSubnet1Prefix

echo "Creating VM subnet for VNet2..."
az network vnet subnet create --name $vmSubnetName --resource-group $resourceGroupName --vnet-name $vnet2Name --address-prefix $vmSubnet2Prefix

echo "Creating VM in VNet1..."
az vm create \
   --resource-group $resourceGroupName \
   --name $vm1Name \
   --location $location \
   --vnet-name $vnet1Name \
   --subnet $vmSubnetName \
   --image Ubuntu2204 \
   --size Standard_D2s_v3 \
   --admin-username azureuser \
   --generate-ssh-keys \
   --public-ip-sku Standard

echo "Creating VM in VNet2..."
az vm create \
   --resource-group $resourceGroupName \
   --name $vm2Name \
   --location $location \
   --vnet-name $vnet2Name \
   --subnet $vmSubnetName \
   --image Ubuntu2204 \
   --size Standard_D2s_v3 \
   --admin-username azureuser \
   --generate-ssh-keys \
   --public-ip-address ""

echo "Script execution completed."
