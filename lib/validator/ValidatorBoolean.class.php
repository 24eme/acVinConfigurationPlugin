<?php
class ValidatorBoolean extends sfValidatorBoolean
{

  /**
   * @see sfValidatorBase
   */
  protected function doClean($value)
  {
    if (in_array($value, $this->getOption('true_values')))
    {
      return 1;
    }

    if (in_array($value, $this->getOption('false_values')))
    {
      return 0;
    }

    throw new sfValidatorError($this, 'invalid', array('value' => $value));
  }
	
}