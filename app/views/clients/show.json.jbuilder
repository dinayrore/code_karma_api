json.name JSON.parse(@client_dashboard_data)['info']['name']
json.nickname JSON.parse(@client_dashboard_data)['info']['nickname']
json.email JSON.parse(@client_dashboard_data)['info']['email']
json.image JSON.parse(@client_dashboard_data)['info']['image']
json.github JSON.parse(@client_dashboard_data)['info']['urls']['GitHub']
json.call(@client, :organization_name, :organization_site)
