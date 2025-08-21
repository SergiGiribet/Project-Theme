import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { getShoppingList } from '../data/recipes';
import { ShoppingCartIcon, ArrowLeftIcon, CheckIcon, PrinterIcon, DownloadIcon } from 'lucide-react';
const ShoppingListPage = () => {
  const shoppingList = getShoppingList();
  const [checkedItems, setCheckedItems] = useState<{
    [key: string]: boolean;
  }>({});
  const toggleItem = (item: string) => {
    setCheckedItems(prev => ({
      ...prev,
      [item]: !prev[item]
    }));
  };
  const handlePrint = () => {
    window.print();
  };
  return <div className="max-w-2xl mx-auto px-4">
      <Link to="/" className="inline-flex items-center text-green-600 hover:underline mb-6">
        <ArrowLeftIcon size={16} className="mr-1" />
        Volver al menú semanal
      </Link>
      <div className="bg-white rounded-lg shadow-lg overflow-hidden">
        <div className="p-4 sm:p-6">
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 sm:gap-0 mb-6">
            <h1 className="text-xl sm:text-2xl font-bold text-gray-800 flex items-center">
              <ShoppingCartIcon className="mr-2" size={24} />
              Lista de Compra Semanal
            </h1>
            <button onClick={handlePrint} className="flex items-center px-3 py-2 bg-gray-100 hover:bg-gray-200 rounded-lg text-gray-700 w-full sm:w-auto justify-center sm:justify-start">
              <PrinterIcon size={16} className="mr-1" />
              Imprimir
            </button>
          </div>
          <div className="mb-4">
            <p className="text-sm sm:text-base text-gray-600">
              Esta lista incluye todos los ingredientes necesarios para las
              recetas de tu menú semanal.
            </p>
          </div>
          <div className="border rounded-lg overflow-hidden">
            <div className="bg-gray-50 px-4 py-3 border-b">
              <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-1">
                <span className="font-medium text-gray-700">
                  Ingredientes ({shoppingList.length})
                </span>
                <span className="text-sm text-gray-500">
                  {Object.values(checkedItems).filter(Boolean).length} de{' '}
                  {shoppingList.length} comprados
                </span>
              </div>
            </div>
            <ul className="divide-y">
              {shoppingList.map((item, index) => <li key={index} className="px-4 py-3 flex items-center">
                  <button onClick={() => toggleItem(item)} className={`w-5 h-5 rounded border mr-3 flex items-center justify-center ${checkedItems[item] ? 'bg-green-500 border-green-500 text-white' : 'border-gray-300'}`}>
                    {checkedItems[item] && <CheckIcon size={14} />}
                  </button>
                  <span className={`${checkedItems[item] ? 'line-through text-gray-400' : 'text-gray-700'}`}>
                    {item}
                  </span>
                </li>)}
            </ul>
          </div>
          <div className="mt-6 text-center">
            <p className="text-xs sm:text-sm text-gray-500">
              Puedes marcar los ingredientes a medida que los compras.
            </p>
          </div>
        </div>
      </div>
    </div>;
};
export default ShoppingListPage;