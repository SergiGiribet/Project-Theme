import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Recipe, addRecipeToDay } from '../data/recipes';
import { ClockIcon, ChefHatIcon, PlusIcon, CheckIcon } from 'lucide-react';
interface RecipeSuggestionsProps {
  recipes: Recipe[];
}
const days = [{
  id: 'monday',
  name: 'Lunes'
}, {
  id: 'tuesday',
  name: 'Martes'
}, {
  id: 'wednesday',
  name: 'Miércoles'
}, {
  id: 'thursday',
  name: 'Jueves'
}, {
  id: 'friday',
  name: 'Viernes'
}, {
  id: 'saturday',
  name: 'Sábado'
}, {
  id: 'sunday',
  name: 'Domingo'
}];
const mealTypes = [{
  id: 'breakfast',
  name: 'Desayuno'
}, {
  id: 'lunch',
  name: 'Almuerzo'
}, {
  id: 'dinner',
  name: 'Cena'
}];
const RecipeSuggestions: React.FC<RecipeSuggestionsProps> = ({
  recipes
}) => {
  const [addingRecipe, setAddingRecipe] = useState<number | null>(null);
  const [selectedDay, setSelectedDay] = useState<string>('monday');
  const [selectedMeal, setSelectedMeal] = useState<string>('lunch');
  const [addedRecipes, setAddedRecipes] = useState<{
    [key: number]: boolean;
  }>({});
  if (recipes.length === 0) {
    return <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md text-center">
        <p className="text-sm sm:text-base text-gray-500">
          No se encontraron recetas que coincidan con los ingredientes
          detectados. Intenta con otra imagen o añade más ingredientes a tu
          nevera.
        </p>
      </div>;
  }
  const handleAddRecipe = (recipeId: number) => {
    if (addingRecipe === recipeId) {
      // Confirmar la adición
      addRecipeToDay(selectedDay, selectedMeal, recipeId);
      setAddedRecipes(prev => ({
        ...prev,
        [recipeId]: true
      }));
      setAddingRecipe(null);
    } else {
      // Mostrar selector
      setAddingRecipe(recipeId);
    }
  };
  const difficultyColor = (difficulty: string) => {
    return {
      Fácil: 'bg-green-100 text-green-800',
      Media: 'bg-yellow-100 text-yellow-800',
      Difícil: 'bg-red-100 text-red-800'
    }[difficulty] || 'bg-gray-100 text-gray-800';
  };
  return <div className="grid gap-6 grid-cols-1 md:grid-cols-2">
      {recipes.map(recipe => <div key={recipe.id} className="bg-white rounded-lg shadow-md overflow-hidden">
          <div className="h-40 sm:h-48 bg-cover bg-center" style={{
        backgroundImage: `url(${recipe.image})`
      }}></div>
          <div className="p-4">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">
              {recipe.name}
            </h3>
            <div className="flex flex-wrap gap-2 mb-3">
              <span className="flex items-center text-sm text-gray-500">
                <ClockIcon size={14} className="mr-1" />
                {recipe.prepTime} min
              </span>
              <span className={`flex items-center text-sm px-2 py-0.5 rounded-full ${difficultyColor(recipe.difficulty)}`}>
                <ChefHatIcon size={14} className="mr-1" />
                {recipe.difficulty}
              </span>
            </div>
            <p className="text-sm text-gray-600 mb-4 line-clamp-2">
              {recipe.description}
            </p>
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 sm:gap-0">
              <Link to={`/receta/${recipe.id}`} className="text-green-600 text-sm font-medium hover:underline">
                Ver receta completa
              </Link>
              {addedRecipes[recipe.id] ? <span className="flex items-center text-sm text-green-600 font-medium">
                  <CheckIcon size={16} className="mr-1" />
                  Añadido al menú
                </span> : addingRecipe === recipe.id ? <div className="flex flex-wrap items-center gap-2 w-full sm:w-auto">
                  <select value={selectedDay} onChange={e => setSelectedDay(e.target.value)} className="text-sm border rounded py-1 px-2 flex-grow sm:flex-grow-0">
                    {days.map(day => <option key={day.id} value={day.id}>
                        {day.name}
                      </option>)}
                  </select>
                  <select value={selectedMeal} onChange={e => setSelectedMeal(e.target.value)} className="text-sm border rounded py-1 px-2 flex-grow sm:flex-grow-0">
                    {mealTypes.map(meal => <option key={meal.id} value={meal.id}>
                        {meal.name}
                      </option>)}
                  </select>
                  <button onClick={() => handleAddRecipe(recipe.id)} className="bg-green-600 text-white p-1 rounded hover:bg-green-700">
                    <CheckIcon size={16} />
                  </button>
                </div> : <button onClick={() => handleAddRecipe(recipe.id)} className="flex items-center text-sm bg-green-600 text-white px-3 py-1.5 rounded hover:bg-green-700 w-full sm:w-auto justify-center sm:justify-start">
                  <PlusIcon size={16} className="mr-1" />
                  Añadir al menú
                </button>}
            </div>
          </div>
        </div>)}
    </div>;
};
export default RecipeSuggestions;