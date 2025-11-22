// Stub implementation for csv-writer when package is not available
export function createObjectCsvWriter(options: any) {
  return {
    writeRecords: () => Promise.resolve(),
  };
}