<?php

namespace App\View\Helper;

use Cake\View\Helper;
use Cake\View\View;

class TableHelper extends Helper
{
    public function createTable(
        $tableEntries,
        $tableDisplayFields
    )
    {
        $output = "<table>";
        $output .= $this->_preapareTableHeader($tableDisplayFields);
        foreach ($tableEntries as $entry)
        {
            $output .= $this->_preapareTableRow($entry, $tableDisplayFields);
        }
        $output .= "</table>";
        return $output;
    }

    private function _preapareTableHeader($tableDisplayFields) {
        $output = "<tr>";
        foreach($tableDisplayFields as $tableDisplayFieldName){
            $output .= "<th>" . ucfirst($tableDisplayFieldName) . "</th>";
        }
        $output .= "</tr>";
        return $output;
    }

    private function _preapareTableRow($entry, $tableDisplayFields){
        $output = "<tr>";
        foreach($tableDisplayFields as $type){
            $output .= '<td>'. $entry->$type .'</td>';
        }
        $output .= "</tr>";
        return $output;
    }
}