import React, { useState, useRef } from 'react';
import { CameraIcon, ImageIcon, XIcon } from 'lucide-react';
interface ImageUploaderProps {
  onImageSelected: (file: File) => void;
}
const ImageUploader: React.FC<ImageUploaderProps> = ({
  onImageSelected
}) => {
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    // Verificar si es una imagen
    if (!file.type.startsWith('image/')) {
      setError('Por favor selecciona un archivo de imagen válido');
      return;
    }
    // Resetear errores previos
    setError(null);
    // Crear URL para previsualización
    const objectUrl = URL.createObjectURL(file);
    setPreviewUrl(objectUrl);
    // Enviar archivo al componente padre
    onImageSelected(file);
    // Limpiar el input para permitir seleccionar el mismo archivo nuevamente
    if (e.target) {
      e.target.value = '';
    }
  };
  const handleCameraClick = () => {
    if (fileInputRef.current) {
      fileInputRef.current.click();
    }
  };
  const handleRemoveImage = () => {
    setPreviewUrl(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };
  return <div className="w-full">
      <div className="mb-4">
        <h3 className="text-lg font-medium text-gray-700 mb-2">
          Foto de tu nevera
        </h3>
        <p className="text-sm text-gray-500 mb-4">
          Toma una foto del interior de tu nevera para detectar ingredientes
          disponibles
        </p>
      </div>
      <input type="file" accept="image/*" capture="environment" onChange={handleFileChange} ref={fileInputRef} className="hidden" />
      {!previewUrl ? <div onClick={handleCameraClick} className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center cursor-pointer hover:bg-gray-50">
          <div className="flex flex-col items-center justify-center">
            <CameraIcon size={48} className="text-gray-400 mb-3" />
            <p className="text-gray-500 mb-2">Haz clic para tomar una foto</p>
            <p className="text-xs text-gray-400">
              o seleccionar una imagen de tu dispositivo
            </p>
          </div>
        </div> : <div className="relative">
          <img src={previewUrl} alt="Previsualización" className="w-full h-64 object-cover rounded-lg" />
          <button onClick={handleRemoveImage} className="absolute top-2 right-2 bg-red-500 text-white p-1 rounded-full hover:bg-red-600">
            <XIcon size={20} />
          </button>
        </div>}
      {error && <p className="text-red-500 mt-2 text-sm">{error}</p>}
    </div>;
};
export default ImageUploader;