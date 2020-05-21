<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;
use Cake\ORM\RulesChecker;
use Cake\ORM\Rule\IsUnique;

class ProductsTable extends Table
{

    public function validationDefault(Validator $validator)
    {
        $validator->add(
            'title', 
            ['unique' => [
                'rule' => 'validateUnique', 
                'provider' => 'table', 
                'message' => 'Product name not unique']
            ]
        );

        return $validator;
    }

    public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->isUnique(['title']));

        return $rules;
    }

}