// Enhanced stub implementation for jszip when package is not available
class JSZip {
  files: { [key: string]: any } = {};
  
  file(name: string, data?: any) {
    if (data !== undefined) {
      this.files[name] = data;
      return this;
    }
    return this.files[name] || null;
  }
  
  generateAsync(options: any) {
    return Promise.resolve(Buffer.alloc(0));
  }
  
  loadAsync(data: any) {
    return Promise.resolve(this);
  }
}

// Export as constructor function
export = JSZip;