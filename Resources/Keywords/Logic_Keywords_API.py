def get_all_keys(data, keys=None):
    if keys is None:
        keys = set()
    if isinstance(data, dict):
        for key, value in data.items():
            keys.add(key)
            get_all_keys(value, keys)
    elif isinstance(data, list):
        for item in data:
            get_all_keys(item, keys)
    return list(keys)
    
