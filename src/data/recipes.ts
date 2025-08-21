import { UserSettings, DietType, AllergyType } from './settings';
export interface Recipe {
  id: number;
  name: string;
  image: string;
  description: string;
  difficulty: 'Fácil' | 'Media' | 'Difícil';
  prepTime: number; // en minutos
  ingredients: string[];
  instructions: string[];
  nutrition: {
    calories: number;
    protein: number;
    carbs: number;
    fat: number;
  };
  mealType: 'Desayuno' | 'Almuerzo' | 'Cena';
  // Nuevos campos para filtrado de dietas y alergias
  dietTypes?: DietType[];
  allergens?: AllergyType[];
}
export const recipes: Recipe[] = [{
  id: 1,
  name: 'Ensalada mediterránea',
  image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
  description: 'Una refrescante ensalada con ingredientes mediterráneos.',
  difficulty: 'Fácil',
  prepTime: 15,
  ingredients: ['200g de lechuga mixta', '100g de tomates cherry', '1 pepino', '100g de queso feta', '50g de aceitunas negras', '1 cebolla roja', '2 cucharadas de aceite de oliva', '1 cucharada de vinagre balsámico', 'Sal y pimienta al gusto'],
  instructions: ['Lavar y cortar la lechuga en trozos pequeños.', 'Cortar los tomates cherry por la mitad.', 'Pelar y cortar el pepino en rodajas.', 'Cortar la cebolla roja en juliana fina.', 'Desmigar el queso feta.', 'Mezclar todos los ingredientes en un bol grande.', 'Aliñar con aceite de oliva, vinagre balsámico, sal y pimienta.'],
  nutrition: {
    calories: 320,
    protein: 12,
    carbs: 15,
    fat: 24
  },
  mealType: 'Almuerzo',
  dietTypes: ['vegetarian', 'vegan', 'gluten_free'],
  allergens: ['nuts']
}, {
  id: 2,
  name: 'Pollo al horno con patatas',
  image: 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  description: 'Un plato completo de pollo al horno con patatas y verduras.',
  difficulty: 'Media',
  prepTime: 60,
  ingredients: ['4 muslos de pollo', '500g de patatas', '2 zanahorias', '1 cebolla', '4 dientes de ajo', '2 cucharadas de aceite de oliva', '1 cucharadita de romero', '1 cucharadita de tomillo', 'Sal y pimienta al gusto'],
  instructions: ['Precalentar el horno a 200°C.', 'Pelar y cortar las patatas en trozos medianos.', 'Pelar y cortar las zanahorias en rodajas.', 'Cortar la cebolla en cuartos.', 'Colocar las verduras en una bandeja de horno.', 'Colocar los muslos de pollo encima de las verduras.', 'Añadir los ajos enteros con piel.', 'Rociar con aceite de oliva y espolvorear las hierbas, sal y pimienta.', 'Hornear durante 45-50 minutos hasta que el pollo esté dorado y las patatas tiernas.'],
  nutrition: {
    calories: 580,
    protein: 35,
    carbs: 45,
    fat: 28
  },
  mealType: 'Cena',
  dietTypes: ['regular', 'low_carb'],
  allergens: []
}, {
  id: 3,
  name: 'Tostadas de aguacate',
  image: 'https://images.unsplash.com/photo-1603046891744-76f2e0e9f5c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
  description: 'Deliciosas tostadas con aguacate, perfectas para un desayuno nutritivo.',
  difficulty: 'Fácil',
  prepTime: 10,
  ingredients: ['2 rebanadas de pan integral', '1 aguacate maduro', 'Zumo de medio limón', 'Sal y pimienta al gusto', 'Hojuelas de chile (opcional)', '2 huevos (opcional para versión con huevo)'],
  instructions: ['Tostar el pan hasta que esté crujiente.', 'Cortar el aguacate por la mitad, quitar el hueso y sacar la pulpa.', 'En un bol, machacar el aguacate con un tenedor.', 'Añadir el zumo de limón, sal y pimienta al gusto.', 'Extender la mezcla de aguacate sobre las tostadas.', 'Si se desea, añadir un huevo frito o pochado encima.', 'Espolvorear con hojuelas de chile si se quiere picante.'],
  nutrition: {
    calories: 280,
    protein: 8,
    carbs: 22,
    fat: 18
  },
  mealType: 'Desayuno',
  dietTypes: ['vegetarian', 'gluten_free'],
  allergens: ['eggs']
}, {
  id: 4,
  name: 'Pasta con salsa de tomate casera',
  image: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
  description: 'Una pasta deliciosa con salsa de tomate casera y albahaca fresca.',
  difficulty: 'Media',
  prepTime: 30,
  ingredients: ['300g de pasta (espaguetis o penne)', '400g de tomates maduros', '1 cebolla', '2 dientes de ajo', '2 cucharadas de aceite de oliva', '1 cucharadita de azúcar', 'Hojas de albahaca fresca', 'Queso parmesano rallado', 'Sal y pimienta al gusto'],
  instructions: ['Cocer la pasta en agua con sal según las instrucciones del paquete.', 'Mientras tanto, picar finamente la cebolla y el ajo.', 'Escaldar los tomates, pelarlos y cortarlos en trozos.', 'En una sartén, calentar el aceite y sofreír la cebolla hasta que esté transparente.', 'Añadir el ajo y cocinar por un minuto más.', 'Agregar los tomates, el azúcar, sal y pimienta.', 'Cocinar a fuego medio durante unos 15 minutos, aplastando los tomates con una cuchara.', 'Escurrir la pasta y mezclarla con la salsa.', 'Servir con hojas de albahaca fresca y queso parmesano rallado.'],
  nutrition: {
    calories: 450,
    protein: 14,
    carbs: 70,
    fat: 12
  },
  mealType: 'Almuerzo',
  dietTypes: ['vegetarian'],
  allergens: ['gluten', 'wheat']
}, {
  id: 5,
  name: 'Batido verde energético',
  image: 'https://images.unsplash.com/photo-1610970881699-44a5587cabec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
  description: 'Un batido nutritivo y energético para comenzar el día.',
  difficulty: 'Fácil',
  prepTime: 5,
  ingredients: ['1 plátano maduro', '1 puñado de espinacas', '1 manzana verde', '200ml de leche de almendras', '1 cucharada de semillas de chía', '1 cucharadita de miel (opcional)'],
  instructions: ['Lavar bien las espinacas y la manzana.', 'Pelar el plátano y cortar la manzana en trozos, quitando el corazón.', 'Añadir todos los ingredientes a una batidora.', 'Batir hasta obtener una mezcla homogénea.', 'Servir inmediatamente.'],
  nutrition: {
    calories: 220,
    protein: 5,
    carbs: 40,
    fat: 5
  },
  mealType: 'Desayuno',
  dietTypes: ['vegetarian', 'vegan', 'gluten_free'],
  allergens: []
}];
export const weeklyMenu = {
  monday: {
    breakfast: 3,
    // ID de la receta
    lunch: 1,
    dinner: 2
  },
  tuesday: {
    breakfast: 5,
    lunch: 4,
    dinner: 1
  },
  wednesday: {
    breakfast: 3,
    lunch: 2,
    dinner: 4
  },
  thursday: {
    breakfast: 5,
    lunch: 1,
    dinner: 2
  },
  friday: {
    breakfast: 3,
    lunch: 4,
    dinner: 1
  },
  saturday: {
    breakfast: 5,
    lunch: 2,
    dinner: 4
  },
  sunday: {
    breakfast: 3,
    lunch: 1,
    dinner: 2
  }
};
export function getShoppingList(): string[] {
  // Simulated function that would normally aggregate all ingredients from the weekly menu
  const allIngredients: string[] = [];
  // Add all ingredients from all recipes in the weekly menu
  Object.values(weeklyMenu).forEach(day => {
    ;
    [day.breakfast, day.lunch, day.dinner].forEach(recipeId => {
      const recipe = recipes.find(r => r.id === recipeId);
      if (recipe) {
        recipe.ingredients.forEach(ingredient => {
          if (!allIngredients.includes(ingredient)) {
            allIngredients.push(ingredient);
          }
        });
      }
    });
  });
  // Sort alphabetically
  return allIngredients.sort();
}

// Función para simular la detección de ingredientes a partir de una imagen
export function detectIngredientsFromImage(imageFile: File): Promise<string[]> {
  // En un caso real, aquí se enviaría la imagen a un servicio de IA para su análisis
  // Para este ejemplo, simulamos la detección con una lista predefinida después de un tiempo
  return new Promise(resolve => {
    setTimeout(() => {
      // Lista simulada de ingredientes detectados
      const detectedIngredients = ['tomates', 'lechuga', 'pepino', 'cebolla', 'queso', 'huevos', 'pimiento', 'zanahoria', 'pollo', 'limón'];
      // Simulamos que se detectan entre 4-7 ingredientes aleatorios
      const numIngredients = Math.floor(Math.random() * 4) + 4;
      const shuffled = [...detectedIngredients].sort(() => 0.5 - Math.random());
      resolve(shuffled.slice(0, numIngredients));
    }, 1500); // Simulamos un tiempo de procesamiento
  });
}

// Función para sugerir recetas basadas en ingredientes detectados
export function suggestRecipesFromIngredients(ingredients: string[], userSettings?: UserSettings): Recipe[] {
  // Convertimos los ingredientes a minúsculas para comparación
  const lowerCaseIngredients = ingredients.map(ing => ing.toLowerCase());
  // Función para calcular cuántos ingredientes de la receta están disponibles
  const calculateMatchScore = (recipe: Recipe): number => {
    let matchCount = 0;
    recipe.ingredients.forEach(recipeIng => {
      // Verificamos si alguno de los ingredientes detectados está en este ingrediente de receta
      if (lowerCaseIngredients.some(detectedIng => recipeIng.toLowerCase().includes(detectedIng))) {
        matchCount++;
      }
    });
    // Calculamos un porcentaje de coincidencia
    return matchCount / recipe.ingredients.length * 100;
  };
  // Primero filtramos por preferencias del usuario si están disponibles
  let filteredRecipes = recipes;
  if (userSettings) {
    filteredRecipes = filterRecipesByUserPreferences(recipes, userSettings);
  }
  // Luego filtramos por coincidencia de ingredientes
  const suggestedRecipes = filteredRecipes.map(recipe => ({
    recipe,
    matchScore: calculateMatchScore(recipe)
  })).filter(item => item.matchScore >= 30).sort((a, b) => b.matchScore - a.matchScore) // Ordenamos por mayor coincidencia
  .map(item => item.recipe);
  return suggestedRecipes;
}

// Función para actualizar el menú semanal con una nueva receta
export function addRecipeToDay(day: string, mealType: string, recipeId: number) {
  // En una aplicación real, esto actualizaría una base de datos
  // Para este ejemplo, simplemente actualizamos el objeto weeklyMenu
  weeklyMenu[day][mealType] = recipeId;
  return {
    ...weeklyMenu
  };
}

// Función para filtrar recetas según las preferencias del usuario
export function filterRecipesByUserPreferences(recipeList: Recipe[], userSettings: UserSettings): Recipe[] {
  return recipeList.filter(recipe => {
    // Filtrar por tipo de dieta
    if (userSettings.dietType !== 'regular') {
      const recipeDietTypes = recipe.dietTypes || [];
      if (!recipeDietTypes.includes(userSettings.dietType)) {
        return false;
      }
    }
    // Filtrar por alergias
    if (userSettings.allergies.length > 0) {
      const recipeAllergens = recipe.allergens || [];
      // Si la receta contiene algún alérgeno que el usuario ha marcado, excluirla
      if (recipeAllergens.some(allergen => userSettings.allergies.includes(allergen))) {
        return false;
      }
    }
    return true;
  });
}