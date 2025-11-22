// Stub implementation for pdfkit when package is not available
class PDFDocument {
  constructor(options?: any) {}
  
  pipe(stream: any) {
    return this;
  }
  
  fontSize(size: number) {
    return this;
  }
  
  text(text: string, x?: number, y?: number, options?: any) {
    return this;
  }
  
  moveDown(lines?: number) {
    return this;
  }
  
  end() {
    return this;
  }
  
  on(event: string, callback: Function) {
    return this;
  }
}

export default PDFDocument;