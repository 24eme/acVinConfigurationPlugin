<?php
/**
 * Model for ConfigurationLieu
 *
 */

class ConfigurationLieu extends BaseConfigurationLieu 
{
	
	const TYPE_NOEUD = 'lieu';

    protected function loadAllData() 
    {
        parent::loadAllData();
        $this->hasCepage();
    }

    public function getMention() 
    {
        return $this->getParentNode();
    }
    public function getAppellation() 
    {
        return $this->getMention()->getAppellation();
    }

    public function getCertification() 
    {
        return $this->getAppellation()->getCertification();
    }

    public function hasCepage() 
    {
        return $this->store('has_cepage', array($this, 'hasCepageStore'));
    }

    public function hasCepageStore() 
    {
        foreach($this->couleurs as $couleur) {
            if ($couleur->hasCepage()) {
                return true;
            }
        }
        return false;
    }

    public function setDonneesCsv($datas) 
    {
    	$this->getAppellation()->setDonneesCsv($datas);
    	$this->libelle = ($datas[ProduitCsvFile::CSV_PRODUIT_LIEU_LIBELLE])? $datas[ProduitCsvFile::CSV_PRODUIT_LIEU_LIBELLE] : null;
    	$this->code = ($datas[ProduitCsvFile::CSV_PRODUIT_LIEU_CODE])? $datas[ProduitCsvFile::CSV_PRODUIT_LIEU_CODE] : null;
    	$this->interpro->getOrAdd('INTERPRO-'.$datas[ProduitCsvFile::CSV_PRODUIT_INTERPRO]);
    	$this->setDroitDouaneCsv($datas, ProduitCsvFile::CSV_PRODUIT_LIEU_CODE_APPLICATIF_DROIT);
    	$this->setDroitCvoCsv($datas, ProduitCsvFile::CSV_PRODUIT_LIEU_CODE_APPLICATIF_DROIT); 
    	$this->setDepartementCsv($datas);
    }
    
  	public function hasDepartements() 
  	{
  		return true;
  	}
  	
  	public function hasDroits() 
  	{
  		return true;
  	}
  	
  	public function hasLabels() 
  	{
  		return false;
  	}
  	public function hasDetails() 
  	{
  		return true;
  	}
  	public function hasOIOC() {
  		return false;
  	}
  	
  	public function getTypeNoeud() 
  	{
  		return self::TYPE_NOEUD;
  	}
  	
	public function getLabels($interpro) 
	{
        return $this->getCertification()->getLabels($interpro);
    }

    public function getProduitsByDepartement($departement) 
    {
        $produits = ConfigurationProduitsView::getInstance()->findProduitsByLieu($this->getCertification()->getKey(), '', $this->getHash())->rows;
        if ($departement) {
        	if (!is_array($departement)) {
        		$departement = array($departement);
        	}
        	foreach ($departement as $dep) {
        		$produits = array_merge($produits, ConfigurationProduitsView::getInstance()->findProduitsByLieu($this->getCertification()->getKey(), $dep, $this->getHash())->rows);
        	}
        }
        return $produits;
    }
    
    public function formatProduits($departement, $format = "%co% %ce%") 
    {
    	return ConfigurationProduitsView::getInstance()->formatProduits($this->getProduitsByDepartement($departement), $format);
    }
}