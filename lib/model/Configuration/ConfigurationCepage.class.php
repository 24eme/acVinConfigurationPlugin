<?php
/**
 * Model for ConfigurationCepage
 *
 */

class ConfigurationCepage extends BaseConfigurationCepage {
	
	const TYPE_NOEUD = 'cepage';

    public function getAppellation() {

      return $this->getCouleur()->getLieu()->getAppellation();
    }

    public function getCertification() {

        return $this->getAppellation()->getCertification();
    }

    public function getGenre() {

      return $this->getAppellation()->getGenre();
    }

    public function getLieu() {

      return $this->getCouleur()->getLieu();
    }

    public function getMention() {

      return $this->getLieu()->getMention();
    }

    public function getCepage() {

      return $this;
    }

    public function getCouleur() {
    	return $this->getParentNode();
    }
    
    public function setDonneesCsv($datas) {
    	$this->getCouleur()->setDonneesCsv($datas);
    	$this->libelle = ($datas[ProduitCsvFile::CSV_PRODUIT_CEPAGE_LIBELLE])? $datas[ProduitCsvFile::CSV_PRODUIT_CEPAGE_LIBELLE] : null;
    	$this->code = ($datas[ProduitCsvFile::CSV_PRODUIT_CEPAGE_CODE])? $datas[ProduitCsvFile::CSV_PRODUIT_CEPAGE_CODE] : null;
    	$this->oioc = ($datas[ProduitCsvFile::CSV_PRODUIT_OIOC])? $datas[ProduitCsvFile::CSV_PRODUIT_OIOC] : null;
    	$this->has_vrac = ($datas[ProduitCsvFile::CSV_HAS_VRAC])? 1 : 0;
    }
    
    public function addInterpro($interpro) 
  	{
  		return $this->getParentNode()->addInterpro($interpro);
  	}
  	
  	public function hasDepartements() {
  		return false;
  	}
  	public function hasDroits() {
  		return false;
  	}
  	public function hasLabels() {
  		return false;
  	}
  	public function hasDetails() {
  		return false;
  	}	
  	public function hasOIOC() {
  		return true;
  	}
  	public function hasHasVrac() {
  		return true;
  	}
  	public function getTypeNoeud() {
  		return self::TYPE_NOEUD;
  	}
    
}