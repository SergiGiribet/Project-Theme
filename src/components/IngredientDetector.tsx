import React from 'react';
import { ListIcon, LoaderIcon } from 'lucide-react';
interface IngredientDetectorProps {
  ingredients: string[] | null;
  loading: boolean;
}
const IngredientDetector: React.FC<IngredientDetectorProps> = ({
  ingredients,
  loading
}) => {
  if (loading) {
    return <div className="bg-white p-6 rounded-lg shadow-md mb-6">
        <div className="flex flex-col items-center justify-center py-8">
          <LoaderIcon size={40} className="text-green-500 animate-spin mb-4" />
          <h3 className="text-lg font-medium text-gray-700">
            Analizando imagen...
          </h3>
          <p className="text-sm text-gray-500 mt-2">
            Estamos detectando los ingredientes disponibles en tu nevera
          </p>
        </div>
      </div>;
  }
  if (!ingredients || ingredients.length === 0) {
    return null;
  }
  return <div className="bg-white p-6 rounded-lg shadow-md mb-6">
      <h3 className="text-lg font-medium text-gray-700 mb-4 flex items-center">
        <ListIcon className="mr-2" size={20} />
        Ingredientes detectados
      </h3>
      <div className="flex flex-wrap gap-2 mb-4">
        {ingredients.map((ingredient, index) => <span key={index} className="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">
            {ingredient}
          </span>)}
      </div>
      <p className="text-sm text-gray-500 mt-2">
        Basándonos en estos ingredientes, te sugerimos las siguientes recetas:
      </p>
    </div>;
};
export default IngredientDetector;