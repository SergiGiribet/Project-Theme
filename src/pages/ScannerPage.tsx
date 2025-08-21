import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowLeftIcon, ScanIcon } from 'lucide-react';
import ImageUploader from '../components/ImageUploader';
import IngredientDetector from '../components/IngredientDetector';
import RecipeSuggestions from '../components/RecipeSuggestions';
import { detectIngredientsFromImage, suggestRecipesFromIngredients, Recipe } from '../data/recipes';
import { getUserSettings } from '../data/settings';
const ScannerPage = () => {
  const [isScanning, setIsScanning] = useState(false);
  const [detectedIngredients, setDetectedIngredients] = useState<string[] | null>(null);
  const [suggestedRecipes, setSuggestedRecipes] = useState<Recipe[]>([]);
  const handleImageSelected = async (file: File) => {
    setIsScanning(true);
    setDetectedIngredients(null);
    setSuggestedRecipes([]);
    try {
      // Detectar ingredientes (simulado)
      const ingredients = await detectIngredientsFromImage(file);
      setDetectedIngredients(ingredients);
      // Obtener preferencias del usuario
      const userSettings = getUserSettings();
      // Sugerir recetas basadas en ingredientes y preferencias
      const recipes = suggestRecipesFromIngredients(ingredients, userSettings);
      setSuggestedRecipes(recipes);
    } catch (error) {
      console.error('Error al procesar la imagen:', error);
    } finally {
      setIsScanning(false);
    }
  };
  return <div className="max-w-4xl mx-auto px-4">
      <Link to="/" className="inline-flex items-center text-green-600 hover:underline mb-6">
        <ArrowLeftIcon size={16} className="mr-1" />
        Volver al menú semanal
      </Link>
      <div className="mb-8 text-center">
        <h1 className="text-2xl sm:text-3xl font-bold text-gray-800 mb-2 flex items-center justify-center">
          <ScanIcon className="mr-2" size={28} />
          Escanear Nevera
        </h1>
        <p className="text-sm sm:text-base text-gray-600">
          Toma una foto del interior de tu nevera y te sugeriremos recetas que
          puedes preparar
        </p>
      </div>
      <div className="bg-white p-4 sm:p-6 rounded-lg shadow-md mb-8">
        <ImageUploader onImageSelected={handleImageSelected} />
      </div>
      <IngredientDetector ingredients={detectedIngredients} loading={isScanning} />
      {detectedIngredients && detectedIngredients.length > 0 && !isScanning && <RecipeSuggestions recipes={suggestedRecipes} />}
      {suggestedRecipes.length > 0 && <div className="mt-8 text-center">
          <Link to="/" className="inline-flex items-center bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">
            Ver menú actualizado
          </Link>
        </div>}
    </div>;
};
export default ScannerPage;