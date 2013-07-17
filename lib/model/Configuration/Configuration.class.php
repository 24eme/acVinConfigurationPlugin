<?php
/**
 * Model for Configuration
 *
 */

class Configuration extends BaseConfiguration 
{

  	const DEFAULT_KEY = 'DEFAUT';
  	const CERTIFICATION_AOP = 'AOP';
  	const CERTIFICATION_IGP = 'IGP';
  	const CERTIFICATION_VINSSANSIG = 'VINSSANSIG';
  	const CERTIFICATION_MOUTS = 'MOUTS';

    protected $produits_libelle = null;
    protected $produits_code = null;
    protected $produits = null;
    protected $format_produits = null;

    public function loadAllData() {
      parent::loadAllData();
      $this->loadProduits();
    }

    protected function loadProduits() {
      $this->getProduits();
      $this->getProduitsLibelles();
      $this->getProduitsCodes();
      //$this->getProduitLibelleByHash();
      //$this->getProduitCodeByHash();
    }

    public function constructId() 
    {
        $this->set('_id', "CONFIGURATION");
    }

    public function getProduitsByDepartement($departement) 
    {
    	$produits = array();
        if (!is_array($departement)) {
        	$departement = array($departement);
        }
        foreach ($departement as $dep) {
        	$produits = array_merge($produits, ConfigurationProduitsView::getInstance()->findProduitsByCertificationAndDepartement(self::CERTIFICATION_AOP, $dep)->rows);
        	$produits = array_merge($produits, ConfigurationProduitsView::getInstance()->findProduitsByCertificationAndDepartement(self::CERTIFICATION_IGP, $dep)->rows);
        	$produits = array_merge($produits, ConfigurationProduitsView::getInstance()->findProduitsByCertificationAndDepartement(self::CERTIFICATION_VINSSANSIG, $dep)->rows);
        	$produits = array_merge($produits, ConfigurationProduitsView::getInstance()->findProduitsByCertificationAndDepartement(self::CERTIFICATION_MOUTS, $dep)->rows);
        }
      	return $produits;
    }

    public function getProduitsVracByDepartement($departement) 
    {
    	$produits = array();
        if (!is_array($departement)) {
        	$departement = array($departement);
        }
        foreach ($departement as $dep) {
        	$produits = array_merge($produits, ConfigurationProduitsVracView::getInstance()->findProduitsVracByDepartement($dep)->rows);
        }
      	return $produits;
    }
    
    public function formatVracProduitsByDepartement($departement, $format = "%g% %a% %l% %co% %ce%") 
    {
    	return ConfigurationProduitsView::getInstance()->formatVracProduits($this->getProduitsVracByDepartement($departement), $format);
    }

    public function getProduits() {
        if(is_null($this->produits)) {
          $this->produits = ConfigurationProduitsView::getInstance()->findProduits()->rows;
        }

      	return $this->produits;
    }

    public function formatProduits($format = "%g% %a% %m% %l% %co% %ce% (%code_produit%)") {
      if(is_null($this->format_produits)) {
        $this->format_produits = ConfigurationProduitsView::getInstance()->formatProduits($this->getProduitsByDepartement($departement), $format);
      }
    	
      return $this->format_produits;
    }

    public function getProduitsLibelles() {
      if(is_null($this->produits_libelle)) {
        $this->produits_libelle = ConfigurationProduitsView::getInstance()->getProduitsLibelles();
      }

      return $this->produits_libelle;
    }

    public function getProduitLibelleByHash($hash) {
    	$produits_libelle = $this->getProduitsLibelles();

    	return (array_key_exists($hash, $produits_libelle)) ? $produits_libelle[$hash] : null;
    }

    public function getProduitsCodes() {
      if(is_null($this->produits_code)) {
        $this->produits_code = ConfigurationProduitsView::getInstance()->getProduitsCodes();
      }

      return $this->produits_code;
    }

    public function getProduitCodeByHash($hash) {
      $produits_code = $this->getProduitsCodes();

      return (array_key_exists($hash, $produits_code)) ? $produits_code[$hash] : null;
    }

    private static function normalizeLibelle($libelle) 
    {
      	$libelle = str_ireplace('SAINT-', 'saint ', $libelle);
      	$libelle = preg_replace('/&nbsp;/', ' ', strtolower($libelle));
      	if (!preg_match('/&[^;]+;/', $libelle)) {
			$libelle = html_entity_decode(preg_replace('/&([^;#])[^;]*;/', '\1', htmlentities($libelle, ENT_NOQUOTES, 'UTF-8')));
     	}
      	$libelle = str_replace(array('é', 'è', 'ê'), 'e', $libelle);
      	$libelle = preg_replace('/[^a-z ]/', '', preg_replace('/  */', ' ', preg_replace('/&([a-z])[^;]+;/i', '\1', $libelle)));
     	$libelle = preg_replace('/^\s+/', '', preg_replace('/\s+$/', '', $libelle));

      	return $libelle;
    }

    private function getObjectByLibelle($parent, $libelle, $previous_libelles = null) 
    {
      	$libelle = ($libelle) ? self::normalizeLibelle($libelle) : 'DEFAUT';
      	$obj_id = 'DEFAUT';
      	foreach ( $parent as $obj_key => $obj_obj) {
			if ($libelle == self::normalizeLibelle($obj_obj->getLibelle())) {
  				$obj_id = $obj_key;
			  	break;
			}
      	}
      	$next_libelles = $libelle;
      	if ($previous_libelles) {
			$next_libelles = $previous_libelles.' / '.$libelle;
      	}
      	if (!$parent->exist($obj_id)) {
		  	throw new Exception($next_libelles);
		}
      	return array('obj' => $obj_obj, 'next_libelles' => $next_libelles);
    }

    public function identifyNodeProduct($certification, $genre, $appellation, $mention, $lieu = 'DEFAUT', $couleur = 'DEFAUT', $cepage = 'DEFAUT', $millesime = null) 
    {
      	$hash = $this->identifyProduct($certification, $genre, $appellation, $mention, $lieu, $couleur, $cepage, $millesime);
      	$rwhash = ' ';
      	while ($rwhash != $hash && $rwhash) {
			if ($rwhash != ' ') {
	  			$hash = $rwhash;
	  		}
			$rwhash = preg_replace('/[^\/]*\/DEFAUT\/?$/', '', $hash);
      	}
      	return $hash;
    }

    public function identifyProduct($certification, $genre, $appellation, $mention = 'DEFAULT', $lieu = 'DEFAUT', $couleur = 'DEFAUT', $cepage = 'DEFAUT', $millesime = null) 
    {
      	try {
			$res = $this->getObjectByLibelle($this->declaration->getCertifications(), $certification);
			$res = $this->getObjectByLibelle($res['obj']->getGenres(), $genre, $res['next_libelles']);
			$res = $this->getObjectByLibelle($res['obj']->getAppellations(), $appellation, $res['next_libelles']);
			$res = $this->getObjectByLibelle($res['obj']->getMentions(), $mention, $res['next_libelles']);
			$res = $this->getObjectByLibelle($res['obj']->getLieux(), $lieu, $res['next_libelles']);
			$res = $this->getObjectByLibelle($res['obj']->getCouleurs(), $couleur, $res['next_libelles']);
			$res = $this->getObjectByLibelle($res['obj']->getCepages(), $cepage, $res['next_libelles']);
		} catch(Exception $e) {		
			throw new sfException("Impossible d'indentifier le produit (".$e->getMessage()." [$certification / $genre / $appellation / $mention / $lieu / $couleur / $cepage / $millesime] )");
		}
		return $res['obj']->getHash();
    }

    public function identifyLabels($labels, $separateur = '|') 
    {
      	$label_keys = array();
      	foreach(explode($separateur, $labels) as $l) {
			if ($k = $this->identifyLabel($l)) {
				$label_keys[] = $k;
			}
      	}
      	return $label_keys;
    }

    public function identifyLabel($label) 
    {
      	$label = self::normalizeLibelle($label);
      	foreach ($this->labels as $k => $l) {
			if ($label == self::normalizeLibelle($l)) {
	  			return $k;
	  		}
      	}
      	return false;
    }
    
    public function setLabelCsv($datas) 
    {
    	if ($datas[LabelCsvFile::CSV_LABEL_CODE] && !$this->labels->exist($datas[LabelCsvFile::CSV_LABEL_CODE])) {
    		$this->labels->add($datas[LabelCsvFile::CSV_LABEL_CODE], $datas[LabelCsvFile::CSV_LABEL_LIBELLE]);
    	}
    }

    public function formatLabelsLibelle($labels, $format = "%la%", $separator = ", ") 
    {
      $libelles = $this->getLabelsLibelles($labels);
      return str_replace("%la%", implode($separator, $libelles), $format);
    }

    public function getLabelsLibelles($labels) 
    {
        $libelles = array(); 
        foreach($labels as $key) {
        	if ($key) {
            	$libelles[$key] = ConfigurationClient::getCurrent()->labels->$key;
        	}
        }
        return $libelles;
    }
    
    public function getConfigurationVracByInterpro($interpro) 
    {
    	if (!$this->vrac->interpro->exist($interpro)) {
    		throw new sfException('The configuration object has no vrac configuration for this interpro');
    	}
    	return $this->vrac->interpro->get($interpro);
    }
    
    public function getConfigurationDAIDSByInterpro($interpro) 
    {
    	if (!$this->daids->interpro->exist($interpro)) {
    		throw new sfException('The configuration object has no daids configuration for this interpro');
    	}
    	return $this->daids->interpro->get($interpro);
    }

    public function updateAlias($hashProduit,$alias) {
        $hashProduitKey = str_replace('/', '-', $hashProduit);
        if(!$this->alias->exist($hashProduitKey))
            $this->alias->add($hashProduitKey,array());
        $pos = count($this->alias->get($hashProduitKey));
        $this->alias->get($hashProduitKey)->add($pos,$alias);
    }

    public function save() {
        parent::save();
        ConfigurationClient::getInstance()->cacheResetCurrent();
    }

    public function prepareCache() {
      $this->loadAllData();
    }
}

