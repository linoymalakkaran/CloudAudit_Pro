import api from './api';

export interface Country {
  id: number;
  name: string;
  code: string;
  dialCode?: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface CreateCountryDto {
  name: string;
  code: string;
  dialCode?: string;
  isActive?: boolean;
}

export interface UpdateCountryDto {
  name?: string;
  code?: string;
  dialCode?: string;
  isActive?: boolean;
}

const countryService = {
  getAllCountries: (isActive?: boolean) => {
    const params = isActive !== undefined ? `?isActive=${isActive}` : '';
    return api.get<Country[]>(`/country${params}`);
  },

  getCountryById: (id: number) => {
    return api.get<Country>(`/country/${id}`);
  },

  getCountryByCode: (code: string) => {
    return api.get<Country>(`/country/code/${code}`);
  },

  createCountry: (data: CreateCountryDto) => {
    return api.post<Country>('/country', data);
  },

  updateCountry: (id: number, data: UpdateCountryDto) => {
    return api.patch<Country>(`/country/${id}`, data);
  },

  deleteCountry: (id: number) => {
    return api.delete(`/country/${id}`);
  },

  seedCountries: () => {
    return api.get<{ seeded: number; countries: Country[] }>('/country/seed');
  },
};

export default countryService;
