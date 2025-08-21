// Tipos de dietas disponibles
export type DietType = 'regular' | 'vegetarian' | 'vegan' | 'pescatarian' | 'keto' | 'paleo' | 'low_carb' | 'gluten_free' | 'dairy_free';
// Alergias e intolerancias comunes
export type AllergyType = 'gluten' | 'lactose' | 'nuts' | 'peanuts' | 'shellfish' | 'fish' | 'eggs' | 'soy' | 'wheat';
// Tipo para número de comidas diarias
export type MealsPerDayType = 3 | 4 | 5 | 6;
export interface UserSettings {
  dietType: DietType;
  allergies: AllergyType[];
  mealsPerDay: MealsPerDayType;
}
// Valores predeterminados
const defaultSettings: UserSettings = {
  dietType: 'regular',
  allergies: [],
  mealsPerDay: 3
};
// Función para obtener la configuración actual
export function getUserSettings(): UserSettings {
  const savedSettings = localStorage.getItem('userSettings');
  if (savedSettings) {
    try {
      return JSON.parse(savedSettings);
    } catch (error) {
      console.error('Error parsing saved settings:', error);
      return defaultSettings;
    }
  }
  return defaultSettings;
}
// Función para guardar la configuración
export function saveUserSettings(settings: UserSettings): void {
  localStorage.setItem('userSettings', JSON.stringify(settings));
}
// Opciones de dietas con sus descripciones
export const dietOptions = [{
  value: 'regular',
  label: 'Regular',
  description: 'Sin restricciones dietéticas específicas'
}, {
  value: 'vegetarian',
  label: 'Vegetariana',
  description: 'Sin carne, pero incluye huevos y lácteos'
}, {
  value: 'vegan',
  label: 'Vegana',
  description: 'Sin productos de origen animal'
}, {
  value: 'pescatarian',
  label: 'Pescetariana',
  description: 'Incluye pescado pero no carne'
}, {
  value: 'keto',
  label: 'Cetogénica',
  description: 'Alta en grasas, moderada en proteínas y baja en carbohidratos'
}, {
  value: 'paleo',
  label: 'Paleo',
  description: 'Basada en alimentos que consumían nuestros ancestros cazadores-recolectores'
}, {
  value: 'low_carb',
  label: 'Baja en carbohidratos',
  description: 'Limita la ingesta de carbohidratos'
}, {
  value: 'gluten_free',
  label: 'Sin gluten',
  description: 'Excluye el gluten, una proteína encontrada en el trigo y otros granos'
}, {
  value: 'dairy_free',
  label: 'Sin lácteos',
  description: 'Excluye todos los productos lácteos'
}];
// Opciones de alergias con sus descripciones
export const allergyOptions = [{
  value: 'gluten',
  label: 'Gluten',
  description: 'Proteína presente en trigo, cebada y centeno'
}, {
  value: 'lactose',
  label: 'Lactosa',
  description: 'Azúcar presente en la leche y productos lácteos'
}, {
  value: 'nuts',
  label: 'Frutos secos',
  description: 'Almendras, nueces, avellanas, etc.'
}, {
  value: 'peanuts',
  label: 'Cacahuetes',
  description: 'Alergia específica a los cacahuetes'
}, {
  value: 'shellfish',
  label: 'Mariscos',
  description: 'Camarones, langostas, cangrejos, etc.'
}, {
  value: 'fish',
  label: 'Pescado',
  description: 'Todos los tipos de pescado'
}, {
  value: 'eggs',
  label: 'Huevos',
  description: 'Alergia a los huevos y productos que los contienen'
}, {
  value: 'soy',
  label: 'Soja',
  description: 'Soja y productos derivados'
}, {
  value: 'wheat',
  label: 'Trigo',
  description: 'Específicamente el trigo y sus derivados'
}];
// Opciones para el número de comidas diarias
export const mealsPerDayOptions = [{
  value: 3,
  label: '3 comidas al día',
  description: 'Desayuno, almuerzo y cena (estándar)'
}, {
  value: 4,
  label: '4 comidas al día',
  description: 'Desayuno, almuerzo, merienda y cena'
}, {
  value: 5,
  label: '5 comidas al día',
  description: 'Desayuno, media mañana, almuerzo, merienda y cena'
}, {
  value: 6,
  label: '6 comidas al día',
  description: 'Desayuno, media mañana, almuerzo, merienda, cena y tentempié nocturno'
}];