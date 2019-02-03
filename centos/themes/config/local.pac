function FindProxyForURL(url, host) {
  if (shExpMatch(host, "*.alograg.acer")) {
    return "PROXY 127.0.0.1:80";
  }
  return "DIRECT";
}
