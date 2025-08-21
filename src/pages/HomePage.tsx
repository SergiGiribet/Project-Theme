import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { recipes, weeklyMenu } from '../data/recipes';
import { CalendarIcon, ClockIcon, SearchIcon, FilterIcon } from 'lucide-react';
import SearchBar from '../components/SearchBar';
import RecipesList from '../components/RecipesList';
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
const HomePage = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [showWeeklyMenu, setShowWeeklyMenu] = useState(true);
  const getRecipe = (recipeId: number) => {
    return recipes.find(recipe => recipe.id === recipeId);
  };
  // Función para buscar recetas
  const searchRecipes = (query: string) => {
    if (!query.trim()) {
      setSearchResults([]);
      setShowWeeklyMenu(true);
      return;
    }
    const lowerCaseQuery = query.toLowerCase().trim();
    const filteredRecipes = recipes.filter(recipe => {
      // Buscar en el nombre de la receta
      if (recipe.name.toLowerCase().includes(lowerCaseQuery)) {
        return true;
      }
      // Buscar en la descripción
      if (recipe.description.toLowerCase().includes(lowerCaseQuery)) {
        return true;
      }
      // Buscar en los ingredientes
      if (recipe.ingredients.some(ingredient => ingredient.toLowerCase().includes(lowerCaseQuery))) {
        return true;
      }
      // Buscar por tipo de comida
      if (recipe.mealType.toLowerCase().includes(lowerCaseQuery)) {
        return true;
      }
      // Buscar por nivel de dificultad
      if (recipe.difficulty.toLowerCase().includes(lowerCaseQuery)) {
        return true;
      }
      return false;
    });
    setSearchResults(filteredRecipes);
    setShowWeeklyMenu(filteredRecipes.length === 0);
  };
  // Ejecutar búsqueda cuando cambia la consulta
  useEffect(() => {
    searchRecipes(searchQuery);
  }, [searchQuery]);
  // Manejar cambios en la búsqueda
  const handleSearch = (query: string) => {
    setSearchQuery(query);
  };
  // Vista móvil - Renderiza cada día como una sección separada
  const renderMobileView = () => {
    return <div className="space-y-6">
        {days.map(day => <div key={day.id} className="bg-white rounded-lg shadow overflow-hidden">
            <div className="bg-gray-100 p-3 font-medium text-gray-700 border-b">
              {day.name}
            </div>
            {mealTypes.map(mealType => {
          const recipeId = weeklyMenu[day.id][mealType.id];
          const recipe = getRecipe(recipeId);
          return <div key={`${day.id}-${mealType.id}`} className="p-3 border-b last:border-b-0">
                  <div className="flex items-center">
                    <div className="w-20 flex-shrink-0">
                      <span className="text-sm font-medium text-gray-700">
                        {mealType.name}:
                      </span>
                    </div>
                    {recipe ? <Link to={`/receta/${recipe.id}`} className="flex items-center ml-2">
                        <div className="w-10 h-10 rounded-full bg-cover bg-center" style={{
                  backgroundImage: `url(${recipe.image})`
                }}></div>
                        <div className="ml-3">
                          <span className="text-sm font-medium text-gray-800">
                            {recipe.name}
                          </span>
                          <div className="flex items-center mt-1 text-xs text-gray-500">
                            <ClockIcon size={12} className="mr-1" />
                            <span>{recipe.prepTime} min</span>
                          </div>
                        </div>
                      </Link> : <span className="text-sm text-gray-500 ml-2">
                        No asignado
                      </span>}
                  </div>
                </div>;
        })}
          </div>)}
      </div>;
  };
  // Vista de escritorio - Tabla completa
  const renderDesktopView = () => {
    return <div className="bg-white rounded-lg shadow overflow-hidden">
        <div className="grid grid-cols-8 bg-gray-100 border-b">
          <div className="p-3 font-medium text-gray-500 border-r"></div>
          {days.map(day => <div key={day.id} className="p-3 font-medium text-center text-gray-700 border-r">
              {day.name}
            </div>)}
        </div>
        {mealTypes.map(mealType => <div key={mealType.id} className="grid grid-cols-8 border-b last:border-b-0">
            <div className="p-4 font-medium text-gray-700 bg-gray-50 border-r">
              {mealType.name}
            </div>
            {days.map(day => {
          const recipeId = weeklyMenu[day.id][mealType.id];
          const recipe = getRecipe(recipeId);
          return <div key={`${day.id}-${mealType.id}`} className="p-2 border-r hover:bg-gray-50">
                  {recipe && <Link to={`/receta/${recipe.id}`} className="block">
                      <div className="flex flex-col items-center text-center">
                        <div className="w-16 h-16 rounded-full bg-cover bg-center mb-1" style={{
                  backgroundImage: `url(${recipe.image})`
                }}></div>
                        <span className="text-sm font-medium text-gray-800">
                          {recipe.name}
                        </span>
                        <div className="flex items-center mt-1 text-xs text-gray-500">
                          <ClockIcon size={12} className="mr-1" />
                          <span>{recipe.prepTime} min</span>
                        </div>
                      </div>
                    </Link>}
                </div>;
        })}
          </div>)}
      </div>;
  };
  return <div>
      <div className="mb-8 text-center">
        <h1 className="text-2xl md:text-3xl font-bold text-gray-800 mb-2">
          Planificador de Menú Semanal
        </h1>
        <p className="text-sm md:text-base text-gray-600">
          Organiza tus comidas de la semana y genera tu lista de compras
          automáticamente
        </p>
      </div>

      {/* Barra de búsqueda */}
      <div className="mb-6">
        <SearchBar onSearch={handleSearch} placeholder="Buscar por nombre de receta, ingrediente o tipo de comida..." />
      </div>

      {/* Resultados de búsqueda o menú semanal */}
      {searchQuery && searchResults.length > 0 ? <RecipesList recipes={searchResults} title="Recetas encontradas" /> : searchQuery ? <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md text-center mb-6">
          <p className="text-gray-500">
            No se encontraron recetas para "{searchQuery}".
          </p>
          <p className="text-sm text-gray-400 mt-2">
            Prueba con otros términos o ingredientes.
          </p>
        </div> : <>
          <div className="mb-4 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 sm:gap-0">
            <h2 className="text-xl font-semibold flex items-center">
              <CalendarIcon className="mr-2" size={20} />
              Menú de esta semana
            </h2>
            <Link to="/lista-compra" className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg text-sm font-medium w-full sm:w-auto text-center">
              Ver lista de compra
            </Link>
          </div>

          {/* Vista móvil */}
          <div className="md:hidden">{renderMobileView()}</div>

          {/* Vista de escritorio */}
          <div className="hidden md:block">{renderDesktopView()}</div>
        </>}

      {/* Todas las recetas - siempre visible si no hay búsqueda */}
      {!searchQuery && <div className="mt-12">
          <h2 className="text-xl font-semibold mb-4 flex items-center">
            <SearchIcon className="mr-2" size={20} />
            Todas las recetas
          </h2>
          <RecipesList recipes={recipes} title="" />
        </div>}
    </div>;
};
export default HomePage;