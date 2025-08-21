import React, { useState } from 'react';
import { SearchIcon, XIcon } from 'lucide-react';
interface SearchBarProps {
  onSearch: (query: string) => void;
  placeholder?: string;
}
const SearchBar: React.FC<SearchBarProps> = ({
  onSearch,
  placeholder = 'Buscar recetas por nombre, ingrediente o tipo...'
}) => {
  const [query, setQuery] = useState('');
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setQuery(value);
    onSearch(value);
  };
  const clearSearch = () => {
    setQuery('');
    onSearch('');
  };
  return <div className="relative w-full">
      <div className="relative flex items-center">
        <SearchIcon size={18} className="absolute left-3 text-gray-400" />
        <input type="text" value={query} onChange={handleChange} placeholder={placeholder} className="w-full pl-10 pr-10 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent" />
        {query && <button onClick={clearSearch} className="absolute right-3 text-gray-400 hover:text-gray-600">
            <XIcon size={18} />
          </button>}
      </div>
    </div>;
};
export default SearchBar;