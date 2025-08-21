import React from 'react';
import { Link } from 'react-router-dom';
import { Recipe } from '../data/recipes';
import { ClockIcon, ChefHatIcon } from 'lucide-react';
interface RecipesListProps {
  recipes: Recipe[];
  title?: string;
  emptyMessage?: string;
}
const RecipesList: React.FC<RecipesListProps> = ({
  recipes,
  title = 'Recetas encontradas',
  emptyMessage = 'No se encontraron recetas que coincidan con tu búsqueda.'
}) => {
  const difficultyColor = (difficulty: string) => {
    return {
      Fácil: 'bg-green-100 text-green-800',
      Media: 'bg-yellow-100 text-yellow-800',
      Difícil: 'bg-red-100 text-red-800'
    }[difficulty] || 'bg-gray-100 text-gray-800';
  };
  if (recipes.length === 0) {
    return <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md text-center mt-6">
        <p className="text-gray-500">{emptyMessage}</p>
      </div>;
  }
  return <div className="mt-6">
      {title && <h3 className="text-lg font-semibold text-gray-800 mb-4">
          {title} ({recipes.length})
        </h3>}
      <div className="grid gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
        {recipes.map(recipe => <div key={recipe.id} className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
            <Link to={`/receta/${recipe.id}`}>
              <div className="h-40 bg-cover bg-center" style={{
            backgroundImage: `url(${recipe.image})`
          }}></div>
            </Link>
            <div className="p-4">
              <Link to={`/receta/${recipe.id}`}>
                <h3 className="text-lg font-semibold text-gray-800 mb-2 hover:text-green-600">
                  {recipe.name}
                </h3>
              </Link>
              <div className="flex flex-wrap gap-2 mb-3">
                <span className="flex items-center text-sm text-gray-500">
                  <ClockIcon size={14} className="mr-1" />
                  {recipe.prepTime} min
                </span>
                <span className={`flex items-center text-sm px-2 py-0.5 rounded-full ${difficultyColor(recipe.difficulty)}`}>
                  <ChefHatIcon size={14} className="mr-1" />
                  {recipe.difficulty}
                </span>
                <span className="text-sm text-gray-500">{recipe.mealType}</span>
              </div>
              <p className="text-sm text-gray-600 mb-3 line-clamp-2">
                {recipe.description}
              </p>
              <Link to={`/receta/${recipe.id}`} className="text-green-600 text-sm font-medium hover:underline inline-flex items-center">
                Ver receta completa
              </Link>
            </div>
          </div>)}
      </div>
    </div>;
};
export default RecipesList;