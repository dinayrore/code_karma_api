json.name JSON.parse(@developer_dashboard_data)['info']['name']
json.nickname JSON.parse(@developer_dashboard_data)['info']['nickname']
json.email JSON.parse(@developer_dashboard_data)['info']['email']
json.image JSON.parse(@developer_dashboard_data)['info']['image']
json.github JSON.parse(@developer_dashboard_data)['info']['urls']['GitHub']
json.call(@developer, :skills)
