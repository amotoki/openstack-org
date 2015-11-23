<schedule-event>
    <div if={ show } id="event_{ id }" class="row event-row">
        <div class="col-md-12">
            <div class="row main-event-content" data-event-id="{ id }">
                <div class="col-xs-1 event-type" style="background-color: { eventColor(summit_types_id) }">&nbsp;</div>
                <div class="col-xs-11 event-content">
                    <div class="row">
                        <div class="col-md-6">
                            <i class="fa fa-clock-o icon-clock"></i>&nbsp;<span>{ start_time }</span>&nbsp;/&nbsp;<span>{ end_time }</span>
                        </div>
                        <div class="col-md-1 col-md-offset-12 my-schedule-container" if={ parent.summit.current_user !== null } >
                            <i if={ !own } class="fa fa-plus-circle icon-foreign-event icon-event-action" title="add to my schedule" onclick={ parent.addToMySchedule } ></i>
                            <i if={ own } class="fa fa-check-circle icon-own-event icon-event-action" title="remove from my schedule" onclick={ parent.removeFromMySchedule } ></i>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 event-title">
                            <raw content="{ title }"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">&nbsp;</div>
                    </div>
                    <div class="row">
                        <div class="col-md-12"><i class="fa fa-map-marker icon-map"></i>&nbsp;<span>{ locationName(location_id) }</span></div>
                    </div>
                    <div class="row"><div class="col-md-4 col-md-offset-9 event-type-col">{ summit.event_types[type_id].type }</div></div>
                    <div class="row">
                        <div class="col-md-12">
                            <span each={ tag_id in tags_id } class="label label-default">{ summit.tags[tag_id].name }</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row event-details" id="event_details_{ id }" style="display:none;">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-9"><raw content="{ description }"/></div>
                        <div class="col-md-3">
                            <div data-speaker-id={ speaker_id } class="row speaker-row" each={ speaker_id in speakers_id }>
                                <div class="col-md-4">
                                    <img src="{ summit.speakers[speaker_id].profile_pic }" class="img-circle" alt="{ summit.speakers[speaker_id].name }">
                                </div>
                                <div class="col-md-8">
                                    <div class="row speaker-name-row"><div class="col-md-12">{ summit.speakers[speaker_id].name }</div></div>
                                    <div class="row speaker-position-row"><div class="col-md-12">{ summit.speakers[speaker_id].position }</div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <a href="{ parent.base_url+'event/'+ this.id } " class="btn btn-primary btn-md active btn-warning" role="button">GO TO EVENT</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

    this.summit            = this.parent.summit;
    this.schedule_api      = this.parent.schedule_api;
    this.clicked_event     = {};
    var self               = this;

    this.on('mount', function(){

    // show event details handler (jquery)
    $(document).off("click", ".main-event-content").on( "click", ".main-event-content", function(e) {

            if($(e.target).hasClass('icon-event-action')){
                return false;
            }
            var event_id = $(e.currentTarget).attr('data-event-id');
            var detail   = $('#event_details_'+event_id);

            if ( detail.is( ":hidden" ) ) {
                detail.slideDown( "slow" );
            } else {
                detail.slideUp( "slow" );
            }
            e.preventDefault();
            e.stopPropagation();
            return false;
        });
    });

    locationName(location_id) {
        var location = self.summit.locations[location_id];
        if (typeof location == 'undefined') return 'TBA';
        if(location.class_name === 'SummitVenueRoom') {
        var room = location;
            location = self.summit.locations[room.venue_id];
            return location.name+' - '+room.name;
        }
        return location.name;
    }

    eventColor(summit_types_id){
        if(summit_types_id.length > 1){
            return '#757575';
        }
        return self.summit_types[summit_types_id[0]].color;
    }

    //EVENTS

    this.schedule_api.on('eventAdded2MySchedule',function(event_id) {
        console.log('eventAdded2MySchedule');
        self.clicked_event[event_id].own = true;
        self.update();
        delete self.clicked_event[event_id];
    });

    this.schedule_api.on('eventRemovedFromMySchedule',function(data) {
        console.log('eventRemovedFromMySchedule');
        self.clicked_event[event_id].own = false;
        self.update();
        delete self.clicked_event[event_id];
    });


    addToMySchedule(e) {
        console.log('addToMySchedule');
        self.clicked_event[e.item.id] = e.item;
        self.schedule_api.addEvent2MySchedule(self.summit.id, e.item.id);
    }

    removeFromMySchedule(e) {
        console.log('removeFromMySchedule');
        self.clicked_event[e.item.id] = e.item;
        self.schedule_api.removeEventFromMySchedule(self.summit.id, e.item.id);
    }

    </script>

</schedule-event>