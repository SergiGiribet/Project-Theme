import React from 'react';
import { useParams, Link } from 'react-router-dom';
import { recipes } from '../data/recipes';
import { ClockIcon, ChefHatIcon, ListIcon, ArrowLeftIcon, BarChartIcon } from 'lucide-react';
const RecipePage = () => {
  const {
    id
  } = useParams<{
    id: string;
  }>();
  const recipe = recipes.find(r => r.id === Number(id));
  if (!recipe) {
    return <div className="text-center py-12">
        <h2 className="text-2xl font-bold text-gray-800 mb-4">
          Receta no encontrada
        </h2>
        <Link to="/" className="text-green-600 hover:underline flex items-center justify-center">
          <ArrowLeftIcon size={16} className="mr-1" />
          Volver al menú semanal
        </Link>
      </div>;
  }
  const difficultyColor = {
    Fácil: 'bg-green-100 text-green-800',
    Media: 'bg-yellow-100 text-yellow-800',
    Difícil: 'bg-red-100 text-red-800'
  }[recipe.difficulty];
  return <div className="max-w-4xl mx-auto px-4 sm:px-6">
      <Link to="/" className="inline-flex items-center text-green-600 hover:underline mb-6">
        <ArrowLeftIcon size={16} className="mr-1" />
        Volver al menú semanal
      </Link>
      <div className="bg-white rounded-lg shadow-lg overflow-hidden mb-8">
        <div className="h-48 sm:h-64 bg-cover bg-center" style={{
        backgroundImage: `url(${recipe.image})`
      }}></div>
        <div className="p-4 sm:p-6">
          <h1 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-2">
            {recipe.name}
          </h1>
          <p className="text-gray-600 mb-6">{recipe.description}</p>
          <div className="flex flex-wrap gap-2 sm:gap-4 mb-8">
            <div className="flex items-center bg-gray-100 rounded-full px-3 sm:px-4 py-1 sm:py-2 text-sm">
              <ClockIcon size={16} className="text-gray-600 mr-1 sm:mr-2" />
              <span>{recipe.prepTime} minutos</span>
            </div>
            <div className={`flex items-center rounded-full px-3 sm:px-4 py-1 sm:py-2 text-sm ${difficultyColor}`}>
              <ChefHatIcon size={16} className="mr-1 sm:mr-2" />
              <span>{recipe.difficulty}</span>
            </div>
            <div className="flex items-center bg-gray-100 rounded-full px-3 sm:px-4 py-1 sm:py-2 text-sm">
              <BarChartIcon size={16} className="text-gray-600 mr-1 sm:mr-2" />
              <span>{recipe.nutrition.calories} calorías</span>
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <h2 className="text-xl font-semibold mb-4 flex items-center">
                <ListIcon className="mr-2" size={20} />
                Ingredientes
              </h2>
              <ul className="space-y-2">
                {recipe.ingredients.map((ingredient, index) => <li key={index} className="flex items-start">
                    <span className="inline-block w-2 h-2 rounded-full bg-green-500 mt-2 mr-2"></span>
                    <span>{ingredient}</span>
                  </li>)}
              </ul>
            </div>
            <div>
              <h2 className="text-xl font-semibold mb-4 flex items-center">
                <ChefHatIcon className="mr-2" size={20} />
                Preparación
              </h2>
              <ol className="space-y-4">
                {recipe.instructions.map((step, index) => <li key={index} className="flex">
                    <span className="inline-flex items-center justify-center w-6 h-6 rounded-full bg-green-100 text-green-800 font-medium text-sm mr-3 shrink-0">
                      {index + 1}
                    </span>
                    <span className="text-gray-700">{step}</span>
                  </li>)}
              </ol>
            </div>
          </div>
          <div className="mt-10 pt-6 border-t border-gray-200">
            <h2 className="text-xl font-semibold mb-4">
              Información Nutricional
            </h2>
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4">
              <div className="bg-gray-50 p-3 sm:p-4 rounded-lg text-center">
                <div className="text-xl sm:text-2xl font-bold text-gray-800">
                  {recipe.nutrition.calories}
                </div>
                <div className="text-xs sm:text-sm text-gray-500">Calorías</div>
              </div>
              <div className="bg-gray-50 p-3 sm:p-4 rounded-lg text-center">
                <div className="text-xl sm:text-2xl font-bold text-gray-800">
                  {recipe.nutrition.protein}g
                </div>
                <div className="text-xs sm:text-sm text-gray-500">
                  Proteínas
                </div>
              </div>
              <div className="bg-gray-50 p-3 sm:p-4 rounded-lg text-center">
                <div className="text-xl sm:text-2xl font-bold text-gray-800">
                  {recipe.nutrition.carbs}g
                </div>
                <div className="text-xs sm:text-sm text-gray-500">
                  Carbohidratos
                </div>
              </div>
              <div className="bg-gray-50 p-3 sm:p-4 rounded-lg text-center">
                <div className="text-xl sm:text-2xl font-bold text-gray-800">
                  {recipe.nutrition.fat}g
                </div>
                <div className="text-xs sm:text-sm text-gray-500">Grasas</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>;
};
export default RecipePage;