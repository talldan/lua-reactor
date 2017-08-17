local function registryModule()
  local mounted = {}

  local function getRegistryData(path)
    return mounted[path]
  end

  local function isComponentMounted(path)
    return not not getRegistryData(path)
  end

  local function getLastProps(path)
    if isComponentMounted(path) then
      return getRegistryData(path).lastProps
    end
  end

  local function mountComponentIfRequired(component, props, path)
    if not isComponentMounted(path) then
      mounted[path] = {
        component = component,
        lastProps = props
      }
    end
  end

  return {
    isComponentMounted = isComponentMounted,
    getLastProps = getLastProps,
    mountComponentIfRequired = mountComponentIfRequired
  }
end

return registryModule