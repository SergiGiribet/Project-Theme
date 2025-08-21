import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowLeftIcon, SettingsIcon, SaveIcon, AlertTriangleIcon, CheckCircleIcon, UtensilsIcon } from 'lucide-react';
import { getUserSettings, saveUserSettings, UserSettings, dietOptions, allergyOptions, mealsPerDayOptions, DietType, AllergyType, MealsPerDayType } from '../data/settings';
const SettingsPage = () => {
  const [settings, setSettings] = useState<UserSettings>(getUserSettings());
  const [isSaved, setIsSaved] = useState(false);
  // Manejar cambio de tipo de dieta
  const handleDietChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    setSettings({
      ...settings,
      dietType: e.target.value as DietType
    });
    setIsSaved(false);
  };
  // Manejar cambio de alergias
  const handleAllergyChange = (allergy: AllergyType) => {
    setSettings(prev => {
      const newAllergies = prev.allergies.includes(allergy) ? prev.allergies.filter(a => a !== allergy) // Quitar si ya está seleccionada
      : [...prev.allergies, allergy]; // Añadir si no está seleccionada
      return {
        ...prev,
        allergies: newAllergies
      };
    });
    setIsSaved(false);
  };
  // Manejar cambio de comidas diarias
  const handleMealsPerDayChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    setSettings({
      ...settings,
      mealsPerDay: parseInt(e.target.value) as MealsPerDayType
    });
    setIsSaved(false);
  };
  // Guardar configuración
  const handleSaveSettings = () => {
    saveUserSettings(settings);
    setIsSaved(true);
    // Mostrar mensaje de éxito durante 3 segundos
    setTimeout(() => {
      setIsSaved(false);
    }, 3000);
  };
  // Obtener descripción de la dieta seleccionada
  const getSelectedDietDescription = () => {
    const selectedDiet = dietOptions.find(diet => diet.value === settings.dietType);
    return selectedDiet ? selectedDiet.description : '';
  };
  // Obtener descripción de las comidas diarias seleccionadas
  const getSelectedMealsPerDayDescription = () => {
    const selectedMeals = mealsPerDayOptions.find(option => option.value === settings.mealsPerDay);
    return selectedMeals ? selectedMeals.description : '';
  };
  return <div className="max-w-2xl mx-auto px-4">
      <Link to="/" className="inline-flex items-center text-green-600 hover:underline mb-6">
        <ArrowLeftIcon size={16} className="mr-1" />
        Volver al menú semanal
      </Link>
      <div className="mb-8 text-center">
        <h1 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-2 flex items-center justify-center">
          <SettingsIcon className="mr-2" size={28} />
          Configuración
        </h1>
        <p className="text-sm sm:text-base text-gray-600">
          Personaliza tus preferencias dietéticas y alergias alimentarias
        </p>
      </div>
      {/* Sección de comidas diarias */}
      <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md mb-6">
        <h2 className="text-lg sm:text-xl font-semibold text-gray-800 mb-4 flex items-center">
          <UtensilsIcon size={20} className="mr-2 text-green-600" />
          Comidas diarias
        </h2>
        <div className="mb-4">
          <label htmlFor="meals-per-day-select" className="block text-sm font-medium text-gray-700 mb-2">
            ¿Cuántas comidas haces al día?
          </label>
          <select id="meals-per-day-select" value={settings.mealsPerDay} onChange={handleMealsPerDayChange} className="w-full p-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500">
            {mealsPerDayOptions.map(option => <option key={option.value} value={option.value}>
                {option.label}
              </option>)}
          </select>
          <p className="mt-2 text-xs sm:text-sm text-gray-500">
            {getSelectedMealsPerDayDescription()}
          </p>
        </div>
      </div>
      {/* Sección de tipo de dieta */}
      <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md mb-6">
        <h2 className="text-lg sm:text-xl font-semibold text-gray-800 mb-4">
          Tipo de dieta
        </h2>
        <div className="mb-4">
          <label htmlFor="diet-select" className="block text-sm font-medium text-gray-700 mb-2">
            Selecciona tu tipo de dieta preferida:
          </label>
          <select id="diet-select" value={settings.dietType} onChange={handleDietChange} className="w-full p-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500">
            {dietOptions.map(diet => <option key={diet.value} value={diet.value}>
                {diet.label}
              </option>)}
          </select>
          <p className="mt-2 text-xs sm:text-sm text-gray-500">
            {getSelectedDietDescription()}
          </p>
        </div>
      </div>
      {/* Sección de alergias */}
      <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md mb-6">
        <h2 className="text-lg sm:text-xl font-semibold text-gray-800 mb-4 flex items-center">
          <AlertTriangleIcon size={20} className="mr-2 text-amber-500" />
          Alergias e intolerancias
        </h2>
        <p className="mb-4 text-xs sm:text-sm text-gray-600">
          Selecciona las alergias o intolerancias alimentarias que tienes. Las
          recetas que contengan estos ingredientes serán filtradas.
        </p>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3 mb-4">
          {allergyOptions.map(allergy => <div key={allergy.value} className="flex items-start">
              <input type="checkbox" id={`allergy-${allergy.value}`} checked={settings.allergies.includes(allergy.value as AllergyType)} onChange={() => handleAllergyChange(allergy.value as AllergyType)} className="h-5 w-5 text-green-600 rounded border-gray-300 focus:ring-green-500 mt-0.5" />
              <label htmlFor={`allergy-${allergy.value}`} className="ml-2 block">
                <span className="text-sm font-medium text-gray-700">
                  {allergy.label}
                </span>
                <span className="text-xs text-gray-500 block">
                  {allergy.description}
                </span>
              </label>
            </div>)}
        </div>
      </div>
      {/* Botón de guardar */}
      <div className="flex flex-col sm:flex-row justify-end items-center gap-3 sm:gap-4">
        {isSaved && <div className="flex items-center text-green-600">
            <CheckCircleIcon size={16} className="mr-1" />
            <span>Configuración guardada</span>
          </div>}
        <button onClick={handleSaveSettings} className="flex items-center bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 w-full sm:w-auto justify-center">
          <SaveIcon size={18} className="mr-2" />
          Guardar configuración
        </button>
      </div>
    </div>;
};
export default SettingsPage;