<?php

/**
 * Copyright 2015 OpenStack Foundation
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
final class SummitAttendeeTicket extends DataObject implements ISummitAttendeeTicket
{
    private static $db = array
    (
        // https://www.eventbrite.com/developer/v3/formats/order/#ebapi-std:format-order
        'ExternalOrderId'    => 'Int',
        'ExternalAttendeeId' => 'Int',
        'TicketBoughtDate'   => 'SS_Datetime',
        'TicketChangedDate'  => 'SS_Datetime',
    );

    static $indexes = array
    (
        'Order_Attendee' =>  array('type'=>'unique', 'value'=>'ExternalOrderId,ExternalAttendeeId')
    );

    private static $has_many = array
    (

    );

    private static $defaults = array
    (
    );

    private static $many_many = array
    (

    );

    private static $belongs_to = array
    (

    );

    static $many_many_extraFields = array
    (
    );

    private static $has_one = array
    (
        'TicketType' => 'SummitTicketType',
        'Owner'      => 'SummitAttendee'
    );

    /**
     * @return int
     */
    public function getIdentifier()
    {
        return (int)$this->getField('ID');
    }
}