import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { CalendarDaysIcon, ShoppingCartIcon, HomeIcon, ScanIcon, SettingsIcon, MenuIcon, XIcon } from 'lucide-react';
const Navbar = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };
  return <nav className="bg-green-600 text-white shadow-md">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          <Link to="/" className="flex items-center space-x-2 font-bold text-xl">
            <CalendarDaysIcon size={24} />
            <span>MenuSemanal</span>
          </Link>
          {/* Botón de menú móvil */}
          <button className="md:hidden focus:outline-none" onClick={toggleMenu}>
            {isMenuOpen ? <XIcon size={24} /> : <MenuIcon size={24} />}
          </button>
          {/* Menú de escritorio */}
          <div className="hidden md:flex space-x-4">
            <Link to="/" className="flex items-center space-x-1 px-3 py-2 rounded hover:bg-green-700">
              <HomeIcon size={18} />
              <span>Inicio</span>
            </Link>
            <Link to="/escanear-nevera" className="flex items-center space-x-1 px-3 py-2 rounded hover:bg-green-700">
              <ScanIcon size={18} />
              <span>Escanear Nevera</span>
            </Link>
            <Link to="/lista-compra" className="flex items-center space-x-1 px-3 py-2 rounded hover:bg-green-700">
              <ShoppingCartIcon size={18} />
              <span>Lista de Compra</span>
            </Link>
            <Link to="/configuracion" className="flex items-center space-x-1 px-3 py-2 rounded hover:bg-green-700">
              <SettingsIcon size={18} />
              <span>Configuración</span>
            </Link>
          </div>
        </div>
        {/* Menú móvil desplegable */}
        {isMenuOpen && <div className="md:hidden pb-4">
            <Link to="/" className="flex items-center space-x-1 px-3 py-3 hover:bg-green-700 rounded" onClick={toggleMenu}>
              <HomeIcon size={18} />
              <span>Inicio</span>
            </Link>
            <Link to="/escanear-nevera" className="flex items-center space-x-1 px-3 py-3 hover:bg-green-700 rounded" onClick={toggleMenu}>
              <ScanIcon size={18} />
              <span>Escanear Nevera</span>
            </Link>
            <Link to="/lista-compra" className="flex items-center space-x-1 px-3 py-3 hover:bg-green-700 rounded" onClick={toggleMenu}>
              <ShoppingCartIcon size={18} />
              <span>Lista de Compra</span>
            </Link>
            <Link to="/configuracion" className="flex items-center space-x-1 px-3 py-3 hover:bg-green-700 rounded" onClick={toggleMenu}>
              <SettingsIcon size={18} />
              <span>Configuración</span>
            </Link>
          </div>}
      </div>
    </nav>;
};
export default Navbar;