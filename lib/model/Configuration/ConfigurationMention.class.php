<?php
/**
 * Model for ConfigurationMention
 *
 */

class ConfigurationMention extends BaseConfigurationMention {
	
	  const TYPE_NOEUD = 'mention';

    protected function loadAllData() {
        parent::loadAllData();
        $this->hasCepage();
    }

	/**
     *
     * @return ConfigurationAppellation
     */
    public function getAppellation() {
        return $this->getParentNode();
    }

    public function getCertification() {

        return $this->getAppellation()->getCertification();
    }
    
    public function getLabels($interpro) {

        return $this->getCertification()->getLabels($interpro);
    }

    public function hasCepage() {
        return $this->store('has_cepage', array($this, 'hasCepageStore'));
    }

    public function hasCepageStore() {
        foreach($this->lieux as $lieu) {
            if ($lieu->hasCepage()) {
                return true;
            }
        }
        
        return false;
    }
    
    public function setDonneesCsv($datas) {
    	$this->getAppellation()->setDonneesCsv($datas);
    	$this->libelle = ($datas[ProduitCsvFile::CSV_PRODUIT_MENTION_LIBELLE])? $datas[ProduitCsvFile::CSV_PRODUIT_MENTION_LIBELLE] : null;
    	$this->code = ($datas[ProduitCsvFile::CSV_PRODUIT_MENTION_CODE])? $datas[ProduitCsvFile::CSV_PRODUIT_MENTION_CODE] : null;
    	$this->interpro->getOrAdd('INTERPRO-'.$datas[ProduitCsvFile::CSV_PRODUIT_INTERPRO]);
    	$this->setDroitDouaneCsv($datas, ProduitCsvFile::CSV_PRODUIT_MENTION_CODE_APPLICATIF_DROIT);
    	$this->setDroitCvoCsv($datas, ProduitCsvFile::CSV_PRODUIT_MENTION_CODE_APPLICATIF_DROIT); 

    	$this->setDepartementCsv($datas);
    }
    
  	public function hasDepartements() {
  		return true;
  	}
  	public function hasDroits() {
  		return true;
  	}
  	public function hasLabels() {
  		return false;
  	}
  	public function hasDetails() {
  		return true;
  	}
  	public function hasOIOC() {
  		return false;
  	}
  	public function hasHasVrac() {
  		return false;
  	}
  	public function getTypeNoeud() {
  		return self::TYPE_NOEUD;
  	}

}