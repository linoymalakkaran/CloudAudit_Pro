// Enhanced stub implementation for exceljs when package is not available
export class Workbook {
  worksheets: any[] = [];
  
  addWorksheet(name: string) {
    const worksheet = {
      name,
      addRow: (data: any[]) => ({ values: data }),
      columns: [],
      getCell: (ref: any) => ({ value: null, font: {}, fill: {} }),
      eachRow: (callback: Function) => {},
      rowCount: 0
    };
    this.worksheets.push(worksheet);
    return worksheet;
  }
  
  getWorksheet(index: number) {
    return this.worksheets[index - 1] || null;
  }
  
  get xlsx() {
    return {
      writeFile: (path: string) => Promise.resolve(),
      write: (stream: any) => Promise.resolve(),
      writeBuffer: () => Promise.resolve(Buffer.alloc(0)),
      readFile: (path: string) => Promise.resolve()
    };
  }
}

export default { Workbook };