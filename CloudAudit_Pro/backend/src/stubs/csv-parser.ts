// Enhanced stub implementation for csv-parser when package is not available
function csvParser(options?: any) {
  return {
    on: (event: string, callback: Function) => {},
    pipe: (destination: any) => destination,
    write: (data: any) => {},
    end: () => {}
  };
}

export function parse(data: string) {
  return [];
}

export default csvParser;