import api from './api';

export interface Currency {
  id: number;
  name: string;
  code: string;
  symbol: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface CreateCurrencyDto {
  name: string;
  code: string;
  symbol: string;
  isActive?: boolean;
}

export interface UpdateCurrencyDto {
  name?: string;
  code?: string;
  symbol?: string;
  isActive?: boolean;
}

export interface ExchangeRate {
  id: number;
  fromCurrencyId: number;
  toCurrencyId: number;
  rate: number;
  effectiveDate: string;
  fromCurrency: Currency;
  toCurrency: Currency;
  createdAt: string;
  updatedAt: string;
}

export interface CreateExchangeRateDto {
  fromCurrencyId: number;
  toCurrencyId: number;
  rate: number;
  effectiveDate: string;
}

export interface UpdateExchangeRateDto {
  fromCurrencyId?: number;
  toCurrencyId?: number;
  rate?: number;
  effectiveDate?: string;
}

const currencyService = {
  // Currency endpoints
  getAllCurrencies: (isActive?: boolean) => {
    const params = isActive !== undefined ? `?isActive=${isActive}` : '';
    return api.get<Currency[]>(`/currency${params}`);
  },

  getCurrencyById: (id: number) => {
    return api.get<Currency>(`/currency/${id}`);
  },

  createCurrency: (data: CreateCurrencyDto) => {
    return api.post<Currency>('/currency', data);
  },

  updateCurrency: (id: number, data: UpdateCurrencyDto) => {
    return api.patch<Currency>(`/currency/${id}`, data);
  },

  deleteCurrency: (id: number) => {
    return api.delete(`/currency/${id}`);
  },

  // Exchange Rate endpoints
  getAllExchangeRates: (fromCurrencyId?: number, toCurrencyId?: number) => {
    const params = new URLSearchParams();
    if (fromCurrencyId) params.append('fromCurrencyId', fromCurrencyId.toString());
    if (toCurrencyId) params.append('toCurrencyId', toCurrencyId.toString());
    const queryString = params.toString();
    return api.get<ExchangeRate[]>(`/currency/exchange-rate${queryString ? '?' + queryString : ''}`);
  },

  getExchangeRateById: (id: number) => {
    return api.get<ExchangeRate>(`/currency/exchange-rate/${id}`);
  },

  createExchangeRate: (data: CreateExchangeRateDto) => {
    return api.post<ExchangeRate>('/currency/exchange-rate', data);
  },

  updateExchangeRate: (id: number, data: UpdateExchangeRateDto) => {
    return api.patch<ExchangeRate>(`/currency/exchange-rate/${id}`, data);
  },

  deleteExchangeRate: (id: number) => {
    return api.delete(`/currency/exchange-rate/${id}`);
  },

  convertAmount: (amount: number, fromCurrencyId: number, toCurrencyId: number, date?: string) => {
    const params = new URLSearchParams({
      amount: amount.toString(),
      fromCurrencyId: fromCurrencyId.toString(),
      toCurrencyId: toCurrencyId.toString(),
    });
    if (date) params.append('date', date);
    return api.get<{ convertedAmount: number }>(`/currency/convert?${params.toString()}`);
  },
};

export default currencyService;
