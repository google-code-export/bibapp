## Publication / Publisher Authorities ##

We'll start with the simple case.  For Publications and Publishers, we collect every string variant of their names:

**Note**: It's probably a very good idea to compare based on a cleaned version of the authority values, to eliminate matches missed because of capitalization and punctuation. Things of the form "American Institute of Physics" to "americaninstituteofphysics":

```
name.gsub!(/[^A-Za-z0-9]+/, '').downcase!
```

### Publisher Example ###

  1. American Institute of Physics
  1. AMER INST PHYSICS
  1. American Institute of Physics Inc
  1. AIP
  1. American Institute of Physics Inc., Melville, NY 11747-4502, United States
  1. American Institute of Physics Inc., Woodbury, NY, USA
  1. American Inst of Physics, Woodbury, NY, USA
  1. American Institute of Physics Inc., Melville, United States

Each Publisher record contains an "authority\_id" field, where we can self-join to the chosen authority record.  In the case above, "American Institute of Physics" is the chosen authority record, so each record below can reference #1 in their authority\_id field.

The same simple technique can be applied to Publication records.

### Publication Example ###

  1. Acta Astronaut. | 0094-5765
  1. Acta Astronaut. (UK) | 0094-5765
  1. Acta Astronautica | 0094-5765

Here "Acta Astronautica" is the chosen authority record, so each record above #3 can reference #3 in their authority\_id field.